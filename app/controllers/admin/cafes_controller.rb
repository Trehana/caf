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
        address_attributes: [:id, :address, :suburb, :city, :postal_code, :country_code],
        attach_business_types: [],
        attach_drink_types: [],
        attach_food_types: [],
        business_hours: {
          sun: [:start, :end, :closed],
          mon: [:start, :end, :closed],
          tue: [:start, :end, :closed],
          wed: [:start, :end, :closed],
          thu: [:start, :end, :closed],
          fri: [:start, :end, :closed],
          sat: [:start, :end, :closed]
         })
    end
  end
end
