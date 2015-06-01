class Admin::PagesController < AdminController
  before_action :set_js_vars, only: [:edit, :update, :destroy]

  def set_coverphoto
    #code
  end

  private
    # Set classname for concerns to set the other parameters
    def set_resource_class_name
      @resource_class_name = 'Page'
    end

    def set_js_vars
      gon.push({asset_submit_path: admin_page_assets_path(@resource)})
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      params.require(:page).permit(:title, :body, :meta_tags)
    end
end
