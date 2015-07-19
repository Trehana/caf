# Addresses for cafes, events or anything with address
class Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true

  def country
    Country.new(country_code).name
  end

  def to_s
    "#{address} #{suburb} #{country} #{postal_code}"
  end

  def to_json
    {
      address: address,
      suburb: suburb,
      city: city,
      country: country,
      postal_code: postal_code
    }
  end
end
