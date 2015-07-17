module Admin
  # Profiles Add/Edit/Delete
  class EmergingArtistsController < BaseController
    private

    # Set classname for concerns to set the other parameters
    def set_resource_class_name
      @resource_class_name = 'EmergingArtist'
    end

    def resource_params
      params.require(:cafe).permit(
        :title,
        :body,
        :cover_photo_repeat,
        :exhibition_type,
        address_attributes: [:id, :city, :country_code],
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
