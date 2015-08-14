module Admin
  # Profiles Add/Edit/Delete
  class AdAreasController < BaseController
    private

    # Set classname for concerns to set the other parameters
    def set_resource_class_name
      @resource_class_name = 'AdArea'
    end

    def resource_params
      params.require(:ad_area).permit(:title, :ad_text, :css_class)
    end

    def set_js_vars
    end
  end
end
