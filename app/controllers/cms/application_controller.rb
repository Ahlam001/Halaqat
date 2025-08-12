module Cms
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :authenticate_editor!
  end
end
