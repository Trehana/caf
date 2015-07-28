# PagesController
class PagesController < ApplicationController
  include Common
  before_action :set_page_variables, only: [:show]

  def home
    set_meta_tags title: "#{t('meta_tags.title')}"
    @resource = Page.find('home')
    @body_class = 'homepage'
    set_page_variables
  end

  def subscribe
    Subscriber.subscribe(params[:email]) if params[:email].present?
    redirect_to root_path
  end

  private

  def set_page_variables
    @cover_photo_url = @resource.cover_photo ? @resource.cover_photo.url : '/assets/bg-home-banner-pattern.jpg'
    @cover_photo_repeat = @resource.cover_photo_repeat == 1 ? 'repeat-x' : 'no-repeat'
  end

  # Set classname for concerns to set the other parameters
  def set_resource_class_name
    @resource_class_name = 'Page'
  end
end
