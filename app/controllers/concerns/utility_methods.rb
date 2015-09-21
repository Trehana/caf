# Common methods for frontend controllers
module UtilityMethods
  extend ActiveSupport::Concern

  included do
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
    @parent_category = request.original_fullpath.split('/')[1]
    @body_class = @resource_class.name.underscore unless defined?(@body_class)
    @banner = Banner.first
    
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

  def set_page_variables
    @cover_photo_url = @resource.cover_photo ? @resource.cover_photo.url : '/assets/bg-home-banner-pattern.jpg'
  end
end
