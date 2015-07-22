# Art Galleries
class ArtGallery < ActiveRecord::Base
  include CommonContent
  include AddBusinessHours
  include DefaultImage
  include DefaultAddress
  include ExhibitionTypes

  searchkick callbacks: :async

  paginates_per 6

  has_one :cover_photo, as: :assetable, dependent: :destroy
  has_many :pictures, as: :assetable, dependent: :destroy

  def search_data
    {
      name: title,
      address: (address.address if address),
      suburb: (address.suburb if address),
      city: (address.city if address),
      location: (address.country_code  if address),
      type: array_to_param_hash(exhibition_type_names, false, true),
      opening_hours: business_hours.earlierst_opening_hour_int,
      date: updated_at
    }
  end

  def self.allowed_exhibition_types
    ['Group', 'Solo', 'Contemporary', 'Installation', 'Mixed media', 'Sculpture']
  end
end
