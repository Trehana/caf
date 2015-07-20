module Admin
  # Profiles Add/Edit/Delete
  class EmergingArtistsController < BaseController
    private

    # Set classname for concerns to set the other parameters
    def set_resource_class_name
      @resource_class_name = 'EmergingArtist'
    end

    def resource_params
      params.require(:emerging_artist).permit(
        :title,
        :body,
        :cover_photo_repeat,
        :exhibition_type,
        address_attributes: [:id, :city, :country_code],
        awards_attributes: [:name, :year],
        )
    end
  end
end
