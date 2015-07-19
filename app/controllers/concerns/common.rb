# Common methods for frontend controllers
module Common
  extend ActiveSupport::Concern

  included do
    before_action :set_resource_class_name
    before_action :set_resource_class
    before_action :set_resource, only: [:show, :edit, :update, :destroy]
    before_action :set_html_variables
  end

  def index
    if @search_critera
      @resources = @resource_class.published_content.search @search_critera, page: params[:page]
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
    begin
      @resource = @resource_class.find(params[:id])
    rescue Exception
      respond_to do |format|
        format.html { render 'shared/catch_all_error' }
        format.json { head :no_content, status: :unprocessable_entity }
      end
    end
  end

  def set_html_variables
    @body_class = @resource_class.name.underscore unless defined?(@body_class)

    title = if defined?(@title)
              "#{@title}"
            elsif defined?(@resource) && @resource.try(:title) && !@resource.try(:title).empty?
              "#{@resource.try(:title)}"
            elsif defined?(@resource_class_name)
              @resource_class_name.titleize.pluralize
            else
              nil
            end
    title = title ? "#{title} | #{t('meta_tags.title')}" : "#{t('meta_tags.title')}"
    set_meta_tags title: title,
                  description: t('meta_tags.description'),
                  keywords: "#{t('meta_tags.keywords')}#{@resource.try(:meta_tags) && !@resource.try(:meta_tags).empty? ? ', ' + @resource.try(:meta_tags) : ''}".squish
  end
end
