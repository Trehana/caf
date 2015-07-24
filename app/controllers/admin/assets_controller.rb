module Admin
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
  class AssetsController < BaseController
    layout 'layouts/ckeditor'

    # Skip authorization for create since it breaks the
    # operation (reason under investigation)
    # authorize the create function seperately
    skip_load_and_authorize_resource :only => :create

    # JS vars doesnt need to be set for asset operations
    skip_before_filter :set_js_vars, only: [:destroy]

    def index
      @assets = @nested_resource.send(@resource_class_name.underscore.send("#{check_association[:transform]}"))
      respond_to do |format|
        format.html { render "admin/#{@resource_class_name.underscore.pluralize}/index" }
      end
    end

    def create
      @resource = @resource_class.new(resource_params)
      @resource.assetable = @nested_resource
      authorize! :new, @resource

      # If the type is CoverPhoto automatically deletes the previous file and,
      # replace with newly uploaded file if the new file is valid
      if %w( CoverPhoto ).include?(@resource.class.name)
        assets_array = Asset.where(assetable_type: @nested_resource.class.name, assetable_id: @nested_resource.id, type: @resource.class.name).where.not(id: @resource.id)
        assets_array.destroy_all
      end


      ###
      if @resource.save
        if params[:CKEditor].blank?
          render json: @resource.to_json(only: [:id, :type])
        else
          render text: %"<script type='text/javascript'>
              window.parent.CKEDITOR.tools.callFunction(#{params[:CKEditorFuncNum]}, '#{config.relative_url_root}#{escape_single_quotes(@resource.url_content)}');
            </script>"
        end
      else
        if params[:CKEditor].blank?
          render json: { error: @resource.errors.full_messages.join(',') }, status: 400
        else
          render text: %"<script type='text/javascript'>
              window.parent.CKEDITOR.tools.callFunction(#{params[:CKEditorFuncNum]}, null, '#{escape_single_quotes(@resource.errors.full_messages.first)}');
            </script>"
        end
      end
      ###
    end

    def destroy
      authorize! :destroy, @resource
      @resource.destroy
      respond_to do |format|
        if params[:CKEditor].blank?
          format.json { render nothing: true, status: 204 }
        else
          format.json { render nothing: true, status: 204 }
        end
      end
    end

    private

    def escape_single_quotes(str)
      str.gsub('\\', '\0\0').gsub('</', '<\/').gsub(/\r\n|\n|\r/, '\\n').gsub(/["']/) { |m| "\\#{m}" }
    end

    def set_resource_class_name
      @resource_class_name =  if !(resource_class_name_underscore = params.keys.find { |k| k.include? '_asset' }).nil?
                                resource_class_name_underscore.to_s.sub('_asset', '').classify
                              elsif params[:type]
                                params[:type].classify
                              else
                                'Asset'
                              end
      @resource_class = Object.const_get(@resource_class_name)
    end

    def set_resource_class
      unless (nested_resource_id = params.keys.find { |k| k.include? '_id' }).nil?
        @nested_resource_class = Object.const_get(nested_resource_id.to_s.sub('_id', '').classify)
        @nested_resource = @nested_resource_class.find(params[nested_resource_id.to_sym])
      end

      @resource_index_path = url_for([:admin, @nested_resource, :assets])
    end

    def resource_params
      params.require("#{@resource_class_name.underscore}_asset".to_sym).permit(:data)
    end

    def check_association
      if @nested_resource_class.reflect_on_association(@resource_class_name.underscore.to_sym)
        { association: @nested_resource_class.reflect_on_association(@resource_class_name.underscore.to_sym).macro, transform: 'singularize' }
      elsif @nested_resource_class.reflect_on_association(@resource_class_name.underscore.pluralize.to_sym)
        { association: @nested_resource_class.reflect_on_association(@resource_class_name.underscore.pluralize.to_sym).macro, transform: 'pluralize' }
      else
        { association: nil, transform: nil }
      end
    end
  end
end
