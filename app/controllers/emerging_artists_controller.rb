# EmergingArtists Controller
class EmergingArtistsController < ApplicationController
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
    @resource_class_name = 'EmergingArtist'
  end

  def set_body_class
    @body_class = 'emerging-artists'
  end

  def set_search_criteria
    return unless params[:search]
    @name = params[:search][:name]
    @city = params[:search][:city]
    @location = params[:search][:location]
    @awards = params[:search][:awards]
    @order_by = params[:search][:ordered]
    desc_or_asc = params[:search][:ordered] == 'name' ? 'asc' : 'desc'
    @search_critera = {
      where: {
        name: @name,
        city: @city,
        location: @location,
        awards: @awards
      },
      order: { "#{@order_by}": :"#{desc_or_asc}" }
    }
  end
end
