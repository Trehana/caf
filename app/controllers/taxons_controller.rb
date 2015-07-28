# Taxons Controller
class TaxonsController < ApplicationController
  before_action :find_resource

  def show
    render "#{@resource_class_name.underscore.pluralize}/show"
  end
  #
  def find_resource
    return unless params[:permalink]
    taxon = Taxon.friendly.find(params[:permalink])
    @resource_class_name = taxon.taxonable_type
    @resource_class = Object.const_get(@resource_class_name)
    @resource = @resource = @resource_class.find(taxon.taxonable_id)
    @cover_photo_url = @resource.cover_photo ? @resource.cover_photo.url : '/assets/bg-home-banner-pattern.jpg'
    @parent_category = taxon.parent ? taxon.parent.permalink.split('/').last : nil
  end
end
