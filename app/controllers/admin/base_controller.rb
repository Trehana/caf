module Admin
  # Admin base controller with common concerns included
  class BaseController < ApplicationController
    include Admin::Common
    layout 'admin'
  end
end
