# Common asset handing controller. Can be nested with other resources
# Routes
# ======
#   namespace :admin do
#     resources :pages do
#       resources :assets
#     end
#   end
#
# The asset class has to be sent with _asset suffix to automatically identify the asset class
# Parameters: {"cover_photo_asset"=>{"data"=>#<ActionDispatch::Http::UploadedFil....
#
# The nested resource class will be identified by the nested resource id
# page_id => Page (class)
#
class Admin::AssetsController < AdminController
  def create
    @resource = @resource_class.new(resource_params)
    @resource.assetable = @nested_resource

    # If the association is has_one automatically deletes the previous file and,
    # replace with newly uploaded file if the new file is valid
    association = @nested_resource_class.reflect_on_association(@resource_class_name.underscore.to_sym).macro.to_s
    if association == 'has_one' && @resource.valid? && @nested_resource.send(@resource_class_name.underscore)
      @nested_resource.send(@resource_class_name.underscore).destroy
    end

    if @resource.save
      render json: { message: "success", fileID: @resource.id }, :status => 200
    else
      render json: { error: @resource.errors.full_messages.join(',')}, :status => 400
    end
  end

  private
    def set_resource_class_name
      if resource_class_name_underscore = params.keys.find {|k| k.include? "_asset"}
        @resource_class_name = resource_class_name_underscore.to_s.sub('_asset','').classify
      end
    end

    def resource_params
      if nested_resource_id = params.keys.find {|k| k.include? "_id"}
        @nested_resource_class = Object.const_get(nested_resource_id.to_s.sub('_id','').classify)
        @nested_resource = @nested_resource_class.find(params[nested_resource_id.to_sym])
      end
      params.require("#{@resource_class_name.underscore}_asset".to_sym).permit(:data)
    end
end
