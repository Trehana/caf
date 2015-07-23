# ArtGalleriesController
class ArtGalleriesController < ApplicationController
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
    @resource_class_name = 'ArtGallery'
  end

  def set_body_class
    @body_class = 'art-galleries'
  end

  def set_search_criteria
    @art_gallery_search = params[:art_gallery_search] ? ArtGallerySearch.new(params[:art_gallery_search]) : ArtGallerySearch.new

    return unless params[:art_gallery_search]
    @search_fields = {
      name: @art_gallery_search.name,
      address: @art_gallery_search.address,
      suburb: @art_gallery_search.suburb,
      city: @art_gallery_search.city,
      location: @art_gallery_search.location,
      type: @art_gallery_search.type,
      opening_hours: @art_gallery_search.opening_hours.blank? ? nil : { gte: Time.parse("1970-01-01 #{@art_gallery_search.opening_hours} UTC").to_i }
    }
    
    @search_order = { "#{@art_gallery_search.order_by}": :"#{ @art_gallery_search.order_by == 'name' ? 'asc' : 'desc' }" }
  end
end
