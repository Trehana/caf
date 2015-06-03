class Admin::PagesController < AdminController
  private
    # Set classname for concerns to set the other parameters
    def set_resource_class_name
      @resource_class_name = 'Page'
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      params.require(:page).permit(:title, :body, :meta_tags, :cover_photo_repeat)
    end
end
