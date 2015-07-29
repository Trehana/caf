# Taxons Controller
class TaxonsController < ApplicationController
  before_action :find_resource
  before_action :set_html_variables

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
    @body_class = @resource_class_name.underscore
    @parent_category = taxon.parent ? taxon.parent.permalink.split('/').last : nil
  end

  def set_html_variables
    @parent_category = request.original_fullpath.split('/')[-2]
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
