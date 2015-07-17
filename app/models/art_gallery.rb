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
    attributes.merge(
      address_country_code: address
    )
  end

  def self.allowed_exhibition_types
    ['Group', 'Solo', 'Contemporary', 'Installation', 'Mixed media', 'Sculpture']
  end
end
