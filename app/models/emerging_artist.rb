# Emerging Artist
class EmergingArtist < ActiveRecord::Base
  include CommonContent
  include DefaultImage
  include DefaultAddress

  searchkick callbacks: :async

  paginates_per 6

  has_one :cover_photo, as: :assetable, dependent: :destroy
  has_many :pictures, as: :assetable, dependent: :destroy

  # has_many :awards, as: :awardable, dependent: :destroy
  # accepts_nested_attributes_for :awards

  def search_data
    {
      name: title,
      city: (address.city if address),
      # awards: awards.name_year,
      location: (address.country_code  if address)
    }
  end
end
