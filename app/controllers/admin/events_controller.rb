module Admin
  # Pages Add/Edit/Delete
  class EventsController < BaseController
    private

    # Set classname for concerns to set the other parameters
    def set_resource_class_name
      @resource_class_name = 'Event'
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      params.require(:event).permit(
        :title,
        :description,
        :starts_at,
        :ends_at,
        :opens_at,
        :closes_at,
        :admission,
        :address,
        :cover_photo_repeat,
        set_tags: [],
        address_attributes: [:id, :address, :postal_code, :country_code]
      )
    end
  end
end
