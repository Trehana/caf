# Emerging Artist
class EmergingArtist < ActiveRecord::Base
  include CommonContent
  include DefaultImage
  include DefaultAddress

  searchkick callbacks: :async

  paginates_per 6

  has_one :cover_photo, as: :assetable, dependent: :destroy
  has_many :pictures, as: :assetable, dependent: :destroy

  has_many :awards, as: :awardable, dependent: :destroy
  accepts_nested_attributes_for :awards, reject_if: :all_blank, allow_destroy: true

  def search_data
    {
      name: title,
      address: (address.address if address),
      suburb: (address.suburb if address),
      city: (address.city if address),
      location: (address.country_code  if address),
      awards: award_list,
      date: updated_at
    }
  end

  def artist_address
    return "" if address.blank?
    "#{address.city}, #{address.country}"
  end

  def award_list
    awards.map(&:to_s)
  end
end
