class EmergingArtistSearch
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :name, :address, :suburb, :city, :location, :awards, :order_by


  def initialize(attributes = {})
    self.attributes = attributes
  end

  def attributes=(attributes)
    @name = attributes[:name]
    @address = attributes[:address]
    @suburb = attributes[:suburb]
    @city = attributes[:city]
    @location = attributes[:location]
    @type = attributes[:type]
    @opening_hours = attributes[:opening_hours]
    @order_by = attributes[:order_by]
  end

  def persisted?
    false
  end
end
