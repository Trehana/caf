module Admin
  # Users Add/Edit/Delete/Assign role
  class UsersController < BaseController
    def index
      @users = User.all
    end

    def show
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      if @user.update_attributes(resource_params)
        redirect_to admin_users_path, notice: "User updated."
      else
        redirect_to admin_users_path, alert: "Unable to update user."
      end
    end

    def destroy
      user = User.find(params[:id])
      user.destroy
      redirect_to admin_users_path, notice: "User deleted."
    end

    private

    # Set classname for concerns to set the other parameters
    def set_resource_class_name
      @resource_class_name = 'User'
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      params.require(:user).permit(:role)
    end

    def set_js_vars
      # keep blank
    end
  end
end
