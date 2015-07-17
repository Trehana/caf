module Admin
  # Pages Add/Edit/Delete
  class ArticlesController < BaseController
    private

    # Set classname for concerns to set the other parameters
    def set_resource_class_name
      @resource_class_name = 'Article'
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      params.require(:article).permit(:title, :body, :cover_photo_repeat, attach_categories: [])
    end
  end
end
