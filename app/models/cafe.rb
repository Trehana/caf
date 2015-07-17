# Cafe Reviews, Menu and rating
class Cafe < ActiveRecord::Base
  include CommonContent
  include AddBusinessHours
  include DefaultImage
  include DefaultAddress
  include CafeTypes
  include DrinkTypes
  include FoodTypes

  searchkick callbacks: :async

  paginates_per 6

  has_one :cover_photo, as: :assetable, dependent: :destroy
  has_many :pictures, as: :assetable, dependent: :destroy

  def search_data
    attributes.merge(
      address_country_code: address
    )
  end

  def self.allowed_food_types
    ['All day breakfast', 'Western', 'Fusion', 'Desserts', 'Organic', 'Vegan', 'Ice-cream', 'Pancakes']
  end

  def self.allowed_drink_types
    ['Speciality Coffee', 'Juice', 'Soy']
  end

  def self.allowed_cafe_types
    ['Micro roaster', 'Family friendly', 'Pet friendly', 'Kiosk']
  end
end
