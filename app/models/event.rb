# Events
class Event < ActiveRecord::Base
  include CommonContent
  include DefaultImage
  include Taggable

  searchkick callbacks: :async
  def search_data
    attributes.merge(
      tag_names: tag_names
    )
  end

  paginates_per 9

  has_one :cover_photo, as: :assetable, dependent: :destroy
  has_many :pictures, as: :assetable, dependent: :destroy
  has_one :address, as: :addressable, dependent: :destroy

  def opens_at
    super.utc.strftime("%I:%M %p")
  end

  def closes_at
    super.utc.strftime("%I:%M %p")
  end

  def self.allowed_tags
    %w(coffee art sponsored)
  end
end
