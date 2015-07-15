class ErrorsController < ApplicationController

  def catch_404
    raise ActionController::RoutingError.new(params[:path])
  end

  rescue_from ActionController::RoutingError do |exception|
    respond_to do |format|
      format.html { render 'shared/catch_all_error' }
      format.json { head :no_content, status: :unprocessable_entity }
    end
  end
end
