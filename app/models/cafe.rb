# Cafe Reviews, Menu and rating
class Cafe < ActiveRecord::Base
  include CommonContent
  include AddBusinessHours
  include DefaultImage

  searchkick

  paginates_per 6

  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address
  has_one :cover_photo, as: :assetable, dependent: :destroy
  has_many :pictures, as: :assetable, dependent: :destroy

  def search_data
    attributes.merge(
      address_country_code: address
    )
  end
end
