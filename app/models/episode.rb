
class Episode < ApplicationRecord
  enum source_kind: { youtube: "youtube", upload: "upload" }

  CATEGORIES = [
    ["بودكاست", "podcast"],
    ["فيديو قصير", "short_video"],
    ["وثائقي", "documentary"],
    ["مقابلة", "interview"],
    ["أخرى", "other"]
  ].freeze

  has_one_attached :video_file
  has_one_attached :thumbnail_image

  belongs_to :editor,              optional: true
  belongs_to :created_by_editor,   class_name: "Editor", optional: true
  belongs_to :updated_by_editor,   class_name: "Editor", optional: true

  scope :active, -> { where(active: true) }
  scope :owned_by,  ->(editor_id) { where(editor_id: editor_id) }
  scope :not_owned, ->(editor_id) { where.not(editor_id: editor_id) }
  scope :search_title, ->(q) { q.present? ? where("title ILIKE ?", "%#{q.strip}%") : all }
  scope :by_category, ->(cat) { cat.present? ? where(category: cat) : all }
  scope :by_editor, ->(editor_id) { editor_id.present? ? where(editor_id: editor_id) : all }


  validates :title, presence: true
  validates :source_kind, inclusion: { in: source_kinds.keys }
  validates :source_url, presence: true, if: -> { youtube? }
  validates :video_file, presence: true, if: -> { upload? }
  validates :duration, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validate :video_must_be_mp4, if: -> { video_file.attached? }
  validates :category, inclusion: { in: CATEGORIES.map(&:last) }, allow_nil: true

  before_validation :normalize_youtube!, if: -> { youtube? && source_url.present? }
  before_validation :nullify_source_url_if_upload


  def youtube_id
    return if source_url.blank?
    uri = URI.parse(source_url) rescue nil
    return if uri.nil?
    if uri.host&.include?("youtu")
      if uri.host == "youtu.be"
        uri.path.delete_prefix("/")
      else
        Rack::Utils.parse_query(uri.query).try(:[], "v")
      end
    end
  end

  def looks_like_youtube?
    source_kind == "youtube" || (source_url.present? && source_url.match?(YT_DOMAIN))
  end

  def embed_url
    return unless looks_like_youtube?
    id = youtube_id
    id.present? ? "https://www.youtube.com/embed/#{id}" : nil
  end

  def thumbnail_url_auto
    return unless looks_like_youtube?
    id = youtube_id
    id.present? ? "https://i.ytimg.com/vi/#{id}/hqdefault.jpg" : nil
  end

  def thumbnail_best
    return thumbnail_image if thumbnail_image&.attached?
    return thumbnail_url if thumbnail_url.present?
    auto = thumbnail_url_auto
    return auto if auto.present?

    ActionController::Base.helpers.asset_path("placeholders/video-thumb.png")
  end

  def playable_type
    return :upload  if upload?  || video_file.attached?
    return :youtube if youtube? || youtube_id.present?
    :unknown
  end

  def nullify_source_url_if_upload
    self.source_url = nil if upload?
  end

  def video_must_be_mp4
    ct = video_file.blob&.content_type
    unless ct == "video/mp4"
      errors.add(:video_file, "الرجاء رفع ملف MP4 (H.264/AAC) لضمان عمله في كل المتصفحات")
    end
  end

  def formatted_duration
    return "-" unless duration
    mins, secs = duration.divmod(60)
    hours, mins = mins.divmod(60)
    hours > 0 ? "#{hours} ساعة و #{mins} دقيقة" : "#{mins} دقيقة"
  end

  private

  def normalize_youtube!
    id = youtube_id
    self.source_url = "https://www.youtube.com/watch?v=#{id}" if id.present?
  end
end
