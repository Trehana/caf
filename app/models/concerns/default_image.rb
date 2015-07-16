# Default image for pages and other content types
module DefaultImage
  extend ActiveSupport::Concern

  included do
    # May nedd to change in the future
    def default_image
      pictures.count > 0 ? pictures.first.url(:content) : ActionController::Base.helpers.asset_path('placeholder.png')
    end

    def default_thumb
      pictures.count > 0 ? pictures.first.url(:thumb) : ActionController::Base.helpers.asset_path('placeholder_thumb.png')
    end

    def default_index_thumb
      pictures.count > 0 ? pictures.first.url(:index_thumb) : ActionController::Base.helpers.asset_path('placeholder.png')
    end
  end

  # Class Methods
  module ClassMethods
  end
end
