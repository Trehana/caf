module Admin
  # Galleries Add/Edit/Delete
  class GalleriesController < BaseController
    private

    # Set classname for concerns to set the other parameters
    def set_resource_class_name
      @resource_class_name = 'Gallery'
    end

    def resource_params
      params.require(:gallery).permit(:title)
    end
  end
end
