# Common methods for frontend controllers
module Common
  extend ActiveSupport::Concern

  included do
    before_action :set_resource_class_name
    before_action :set_resource_class
    before_action :set_resource, only: [:show, :edit, :update, :destroy]
    before_action :set_html_variables, only: [:show]
  end

  def index
    if params[:search] && @search_critera
      @resources = @resource_class.published_content.search @search_critera
    else
      @resources = @resource_class.published_content.page params[:page]
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
  end

  private

  def set_resource_class
    @resource_class = Object.const_get(@resource_class_name)
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_resource
    @resource = @resource_class.find(params[:id])
  end

  def set_html_variables
    @body_class = @resource_class.name.underscore unless defined?(@body_class)
    set_meta_tags title: @resource.try(:title) && !@resource.try(:title).empty? ? "#{@resource.try(:title)} | #{t('meta_tags.title')}" : "#{t('meta_tags.title')}",
                  description: t('meta_tags.description'),
                  keywords: "#{t('meta_tags.keywords')}#{@resource.try(:meta_tags) && !@resource.try(:meta_tags).empty? ? ', ' + @resource.try(:meta_tags) : ''}".squish
  end
end
