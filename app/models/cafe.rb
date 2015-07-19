# Cafe Reviews, Menu and rating
class Cafe < ActiveRecord::Base
  include CommonContent
  include AddBusinessHours
  include DefaultImage
  include DefaultAddress
  include Taggable
  include BusinessTypes
  include DrinkTypes
  include FoodTypes

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
      type: array_to_param_hash(business_type_names, false, true),
      food: array_to_param_hash(food_type_names, false, true),
      drinks: array_to_param_hash(drink_type_names, false, true),
      opening_hours: business_hours.earlierst_opening_hour_int
    }
  end

  def self.allowed_food_types
    ['All day breakfast', 'Western', 'Fusion', 'Desserts', 'Organic', 'Vegan', 'Ice-cream', 'Pancakes']
  end

  def self.allowed_drink_types
    ['Speciality Coffee', 'Juice', 'Soy']
  end

  def self.allowed_business_types
    ['Micro roaster', 'Family friendly', 'Pet friendly', 'Kiosk']
  end
end
