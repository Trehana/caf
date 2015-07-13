module Admin
  # Profiles Add/Edit/Delete
  class CafesController < BaseController
    private

    # Set classname for concerns to set the other parameters
    def set_resource_class_name
      @resource_class_name = 'Cafe'
    end

    def resource_params
      params.require(:cafe).permit(
        :title,
        :body,
        :menu,
        :cover_photo_repeat,
        address_attributes: [:id, :address, :postal_code, :country_code],
        business_hours: {
          sun: [:start, :end],
          mon: [:start, :end],
          tue: [:start, :end],
          wed: [:start, :end],
          thu: [:start, :end],
          fri: [:start, :end],
          sat: [:start, :end]
         })
    end
  end
end
