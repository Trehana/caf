# Taxons Controller
class TaxonsController < ApplicationController
  include UtilityMethods

  before_action :set_taxon
  before_action :set_resource_class_name
  before_action :set_resource_class
  before_action :set_resource, only: [:show, :edit, :update, :destroy]
  before_action :set_html_variables
  before_action :set_page_variables

  def show
    render "#{@resource_class_name.underscore.pluralize}/show"
  end
  #
  def set_taxon
    begin
      @taxon = Taxon.friendly.find(params[:permalink])
    rescue Exception
      respond_to do |format|
        format.html { render 'shared/catch_all_error' }
        format.json { head :no_content, status: :unprocessable_entity }
      end
    end
  end

  def set_resource_class_name
    @resource_class_name = @taxon.taxonable_type
  end

  def set_resource
    begin
      @resource = @resource_class.find(@taxon.taxonable_id)
    rescue Exception
      respond_to do |format|
        format.html { render 'shared/catch_all_error' }
        format.json { head :no_content, status: :unprocessable_entity }
      end
    end
  end
end
