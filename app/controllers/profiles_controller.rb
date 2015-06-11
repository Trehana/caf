# ProfilesController
class ProfilesController < ApplicationController
  include Common

  private

  # Set classname for concerns to set the other parameters
  def set_resource_class_name
    @resource_class_name = 'Profile'
  end
end
