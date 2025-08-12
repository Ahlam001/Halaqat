module Cms
  class EpisodesController < Cms::ApplicationController
    layout "application"
    before_action :authenticate_editor!
    before_action :set_episode, only: %i[show edit update]
    before_action :load_sidebar_data, only: %i[index show edit]


    def index
      @tab = params[:tab].presence_in(%w[mine others]) || "mine"

      base_scope = Episode.with_attached_thumbnail_image.includes(:editor).order(created_at: :desc)
      @episodes = if @tab == "mine"
        base_scope.owned_by(current_editor.id)
      else
        base_scope.not_owned(current_editor.id)
      end
    end

    def show
      @episode = Episode.find(params[:id])
    end

    def new
      @episode = current_editor.episodes.build
    end

    def create
      @episode = current_editor.episodes.build(episode_params)
      @episode.created_by_editor = current_editor
      @episode.updated_by_editor = current_editor
      if @episode.save
        redirect_to cms_episode_path(@episode), notice: "تم إنشاء الحلقة"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      @episode.updated_by_editor = current_editor
      if @episode.update(episode_params)
        redirect_to cms_episode_path(@episode), notice: "تم التعديل"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def load_sidebar_data
      @all_editors = Editor.order(:email).select(:id, :email, :role)
    end

    def set_episode
      @episode = Episode.find(params[:id])
    end

    def episode_params
      permitted = params
                    .require(:episode)
                    .permit(:title, :description, :source_url, :duration, :thumbnail_url, :video_file, :published_at, :category, :source_kind, :active)

      permitted[:duration] = permitted[:duration].presence&.to_i
      if (ts = permitted.delete(:published_at)).present?
        permitted[:published_at] = Time.zone.parse(ts) rescue nil
      end
      permitted
    end
  end
end