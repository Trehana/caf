# Common methods for frontend controllers
module Common
  extend ActiveSupport::Concern
  include UtilityMethods

  included do
    before_action :set_resource_class_name
    before_action :set_resource_class
    before_action :set_resource, only: [:show, :edit, :update, :destroy]
    before_action :set_html_variables
  end

  def index
    if defined?(@search_fields)
      # Not feeding searchkick any blanks since it'll look for blanks
      # hence the performance penalty + invalid search results
      @search_fields.delete_if { |k, v| v.blank? }
      #
      @search_critera = {
        search_fields: @search_fields,
        order: defined?(@search_order) ? @search_order : {}
      }

      if @resource_class.published_content.exists?
        search_result = @search_critera[:search_fields].collect { |field, value| @resource_class.published_content.search(value, fields: [field], order: @search_critera[:order]).results }.reduce(:&)
        @resources = Kaminari.paginate_array(search_result).page(params[:page]).per(6)
      else
        @resources = @resource_class.published_content.page params[:page]
      end
    else
      @resources = @resource_class.published_content.page params[:page]
    end
  end

  def show
  end

end
