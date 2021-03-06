# EventsController
class EventsController < ApplicationController
  include Common
  before_action :set_page_variables, only: [:show]
  before_action :set_body_class
  before_action :set_search_criteria, only: [:index]


  def calendar
    @body_class = 'calendarpage'
    @title = 'Calendar'
    set_meta_tags title: "#{t('helpers.label.event.calendar.index_title')} | #{t('meta_tags.title')}"

    if Event.allowed_categories.include?(params[:tag])
      @tag = params[:tag]
      logger = Logger.new(STDOUT)
      logger.debug "-------- ANALYTICS DATA: #{@tag} ----------"
      @body_class << " #{@tag}-related"
      gon.push anchor_location: "category-navigation"
    end
    #
    unless params['start'] && params['end']
      gon.push calendar_tag: @tag
      return
    end
    #
    unless @tag
      @resources = Event.between(params['start'], params['end']) if params['start'] && params['end']
    else
      #@resources = Event.joins(:tags).where(tags: {slug: @tag}).between(params['start'], params['end']) if params['start'] && params['end']
      @resources = Event.joins(:tags).where(tags: {name: @tag, type: 'Category'}).between(params['start'], params['end']) if params['start'] && params['end']
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @resources }
    end
  end

  private

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

    @search_fields = { categories: @tag }
    @search_order = { "#{@order_by}": :"#{desc_or_asc}" }
  end
end
