# PagesController
class CafesController < ApplicationController
  include Common
  before_action :set_page_variables, only: [:show]
  before_action :set_body_class
  before_action :set_search_criteria, only: [:index]

  private

  # Set classname for concerns to set the other parameters
  def set_resource_class_name
    @resource_class_name = 'Cafe'
  end

  def set_body_class
    @body_class = 'coffeeadventurepage'
  end

  def set_search_criteria
    @cafe_search = params[:cafe_search] ? CafeSearch.new(params[:cafe_search]) : CafeSearch.new

    return unless params[:cafe_search]
    @search_fields = {
      name: @cafe_search.name,
      address: @cafe_search.address,
      suburb: @cafe_search.suburb,
      city: @cafe_search.city,
      location: @cafe_search.location,
      type: @cafe_search.type,
      food: @cafe_search.food,
      drinks: @cafe_search.drinks,
      opening_hours: @cafe_search.opening_hours.blank? ? nil : { gte: Time.parse("1970-01-01 #{@cafe_search.opening_hours} UTC").to_i }
    }
    @search_order = { "#{@cafe_search.order_by}": :"#{ @cafe_search.order_by == 'name' ? 'asc' : 'desc' }" }
  end
end
