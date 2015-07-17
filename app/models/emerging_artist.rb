# Emerging Artist
class EmergingArtist < ActiveRecord::Base
  include CommonContent
  include DefaultImage
  include DefaultAddress

  searchkick callbacks: :async

  paginates_per 6

  has_one :cover_photo, as: :assetable, dependent: :destroy
  has_many :pictures, as: :assetable, dependent: :destroy

  def search_data
    attributes.merge(
      address_country_code: address,
      awards: awards
    )
  end
end
