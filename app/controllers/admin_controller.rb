# Admin controller with common concerns included
class AdminController < ApplicationController
  include Admin::Common
  layout 'admin'
end
