class Admin::PagesController < AdminController
  def set_coverphoto
    #code
  end

  private
    # Set classname for concerns to set the other parameters
    def set_resource_class_name
      @resource_class_name = 'Page'
    end
end
