module Admin
  # Profiles Add/Edit/Delete
  class ProfilesController < BaseController
    private

    # Set classname for concerns to set the other parameters
    def set_resource_class_name
      @resource_class_name = 'Profile'
    end

    def resource_params
      params.require(:profile).permit(:title, :designation, :bio_short, :bio)
    end
  end
end
