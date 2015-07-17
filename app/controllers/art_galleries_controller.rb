# PagesController
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
    return unless params[:search]
    @order_by = params[:search][:ordered]
    @country_code = params[:search][:country]
    desc_or_asc = params[:search][:ordered] == 'name' ? 'asc' : 'desc'
    @search_critera =  { where: { country_code: @country_code }, order: { "#{@order_by}": :"#{desc_or_asc}" } }
  end
end