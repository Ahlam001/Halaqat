module Discovery
  class EpisodesController < ApplicationController

    def index
      @q         = params[:q].to_s
      @category  = params[:category].to_s
      @editor_id = params[:editor_id].to_s

      base = Episode.active.includes(:editor).order(created_at: :desc).search_title(@q).by_category(@category).by_editor(@editor_id)

      @categories = Episode::CATEGORIES
      @editors    = Editor.order(:email)

      per_page = [[params[:per].to_i].max, 24].min
      @episodes = base.page(params[:page]).per(per_page.zero? ? 5 : per_page)
    end

    def show
      @episode = Episode.find(params[:id])
    end
  end
end