module Admin
  # Pages Add/Edit/Delete
  class EventsController < BaseController
    def index
      @resources = @resource_class.editors_content.order(starts_at: :desc).page params[:page]
    end

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
        :email,
        :facebook,
        :instagram,
        :pinterest,
        :twitter,
        :organizer,
        :cover_photo_repeat,
        attach_categories: [],
        address_attributes: [:id, :address, :suburb, :city, :postal_code, :country_code]
      )
    end
  end
end
