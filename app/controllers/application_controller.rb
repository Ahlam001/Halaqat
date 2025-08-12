class ApplicationController < ActionController::Base

  class ApplicationController < ActionController::Base
    before_action :set_locale

    def after_sign_in_path_for(resource)
      cms_root_path
    end

    private

    def set_locale
      I18n.locale = :ar
    end
  end
end
