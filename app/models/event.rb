# Events
class Event < ActiveRecord::Base
  include CommonContent
  include DefaultImage
  include Taggable
  include DefaultAddress

  searchkick callbacks: :async
  def search_data
    attributes.merge(
      tag_names: tag_names
    )
  end

  paginates_per 9

  has_one :cover_photo, as: :assetable, dependent: :destroy
  has_many :pictures, as: :assetable, dependent: :destroy

  def opens_at
    return nil unless super
    super.utc.strftime("%I:%M %p")
  end

  def closes_at
    return nil unless super
    super.utc.strftime("%I:%M %p")
  end

  def self.allowed_tags
    %w(coffee art sponsored)
  end
end
