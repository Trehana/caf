# EventsController
class EventsController < ApplicationController
  include Common
  before_action :set_page_variables, only: [:show]
  before_action :set_body_class
  before_action :set_search_criteria, only: [:index]

  def calendar
    # @resources = @resource_class.published_content.page params[:page]
    # respond_to do |format|
    #   format.html { render @resources }
    #   format.json { render @resources, status: :ok }
    # end
    @resources = Event.published_content
    # @resources = Event.between(params['start'], params['end']) if params['start'] && params['end']
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @resources }
    end
  end

  private

  def set_page_variables
    @cover_photo_url = @resource.cover_photo ? @resource.cover_photo.url : '/assets/bg-home-banner-pattern.jpg'
    @cover_photo_repeat = @resource.cover_photo_repeat == 1 ? 'repeat-x' : 'no-repeat'
  end

  # Set classname for concerns to set the other parameters
  def set_resource_class_name
    @resource_class_name = 'Event'
  end

  def set_body_class
    @body_class = 'events'
  end

  def set_search_criteria
    return unless params[:tag]
    @order_by = 'starts_at'
    @tag = params[:tag]
    desc_or_asc = 'desc'
    @search_critera =  { where: { tag_names: @tag }, order: { "#{@order_by}": :"#{desc_or_asc}" } }
  end
end
