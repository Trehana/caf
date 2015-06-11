# Admin controller with common concerns included
class AdminController < ApplicationController
  include Admin::Common
  layout 'admin'

  before_action :authenticate_user!
end
