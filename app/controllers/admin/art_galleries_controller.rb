module Admin
  # Profiles Add/Edit/Delete
  class ArtGalleriesController < BaseController
    private

    # Set classname for concerns to set the other parameters
    def set_resource_class_name
      @resource_class_name = 'ArtGallery'
    end

    def resource_params
      params.require(:cafe).permit(
        :title,
        :body,
        :cover_photo_repeat,
        :exhibition_type,
        address_attributes: [:id, :address, :suburb, :city, :postal_code, :country_code],
        attach_exhibition_types: [],
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
