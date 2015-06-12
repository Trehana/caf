module Admin
  # Users Add/Edit/Delete/Assign role
  class UsersController < BaseController
    private

    # Set classname for concerns to set the other parameters
    def set_resource_class_name
      @resource_class_name = 'User'
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      params.require(:user).permit(:email, :password)
    end
  end
end
