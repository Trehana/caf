# PagesController
class CafesController < ApplicationController
  include Common
  before_action :set_page_variables, only: [:show]
  before_action :set_body_class
  before_action :set_search_criteria, only: [:index]

  private

  def set_page_variables
    @cover_photo_url = @resource.cover_photo ? @resource.cover_photo.url : '/assets/bg-home-banner-pattern.jpg'
    @cover_photo_repeat = @resource.cover_photo_repeat == 1 ? 'repeat-x' : 'no-repeat'
  end

  # Set classname for concerns to set the other parameters
  def set_resource_class_name
    @resource_class_name = 'Cafe'
  end

  def set_body_class
    @body_class = 'coffeeadventurepage'
  end

  def set_search_criteria
    return unless params[:search]
    @name = params[:search][:name]
    @address = params[:search][:address]
    @suburb = params[:search][:suburb]
    @city = params[:search][:city]
    @location = params[:search][:location]
    @type = params[:search][:type]
    @food = params[:search][:food]
    @drinks = params[:search][:drinks]
    @opening_hours = params[:search][:opening_hours]
    @order_by = params[:search][:ordered]
    desc_or_asc = params[:search][:ordered] == 'name' ? 'asc' : 'desc'
    @search_critera = {
      where: {
        name: @name,
        address: @address,
        suburb: @suburb,
        city: @city,
        location: @location,
        type: @type,
        food: @food,
        drinks: @drinks,
        opening_hours: { lte: Time.parse("1970-01-01 #{@opening_hours} UTC").to_i }
      },
      order: { "#{@order_by}": :"#{desc_or_asc}" }
    }
  end
end
