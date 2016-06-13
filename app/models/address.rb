# Addresses for cafes, events or anything with address
class Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true

  validates_presence_of :address, :city, :country

  def country
    Country.new(country_code).name if country_code
  end

  def to_s
    address_string = Array.new
    #%w(address suburb country city postal_code).each do |field|
    %w(address suburb city country postal_code).each do |field|
      address_string << send(field).strip unless send(field).to_s.strip.blank?
    end
    address_string.join(' ')
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
