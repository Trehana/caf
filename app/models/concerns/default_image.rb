# Default image for pages and other content types
module DefaultImage
  extend ActiveSupport::Concern

  included do
    # May nedd to change in the future
    def default_image
      return unless pictures.count > 0
      pictures.first.url(:index_thumb)
    end

    def default_thumb
      return unless pictures.count > 0
      pictures.first.url(:thumb)
    end
  end

  # Class Methods
  module ClassMethods
  end
end
