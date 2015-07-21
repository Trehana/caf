class CafeSearch
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :name, :address, :suburb, :city, :location, :type, :food, :drinks, :opening_hours, :order_by, :date


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
    @food = attributes[:food]
    @drinks = attributes[:drinks]
    @opening_hours = attributes[:opening_hours]
    @order_by = attributes[:order_by]
    @date = attributes[:date]
  end

  def persisted?
    false
  end
end
