module Admin
  # Common methods shared between admin controllers
  module Common
    extend ActiveSupport::Concern

    included do
      load_and_authorize_resource
      before_action :set_resource_class_name
      before_action :set_resource_class
      before_action :set_resource, only: [:show, :edit, :update, :destroy]
      before_action :set_js_vars, only: [:edit, :update, :destroy]
      before_action :fix_shortcode_sanitisation, only: [:update]
      before_action :filter_allowed_tags, only: [:update]
    end

    def index
      @resources = @resource_class.editors_content.page params[:page]
    end

    # GET /pages/new
    def new
      @resource = @resource_class.create
      set_js_vars
      respond_to do |format|
        format.html { render :edit }
        format.json { render :show, status: :ok, location: @resource }
      end
    end

    # GET /pages/1/edit
    def edit
    end

    def create
      @resource = @resource_class.new(resource_params)
      respond_to do |format|
        if @resource.save
          format.html { render :edit }
          format.json { render :show, status: :created, location: @resource }
        else
          format.html { render :new }
          format.json { render json: @resource.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @resource.update(resource_params)
          if params[:button] == 'publish' && @resource.state != 'published'
            @resource.publish
          elsif params[:button] == 'save_draft' && @resource.state != 'save_draft'
            @resource.save_draft
          end
          #
          format.html { render :edit, notice: t('common.messages.updated', resource_class_name: @resource_class_name) }
          format.json { render :show, status: :ok, location: @resource }
        else
          @errors = @resource.errors
          format.html { render :edit }
          format.json { render json: @resource.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @resource.move_to_trash
      respond_to do |format|
        format.html { redirect_to @resource_index_path, notice: t('common.messages.deleted', resource_class_name: @resource_class_name) }
        format.json { head :no_content }
      end
    end

    private

    def set_resource_class
      @resource_class = Object.const_get(@resource_class_name)
      @resource_index_path = "admin_#{@resource_class.name.underscore.pluralize}".to_sym
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_resource
      @resource = @resource_class.find(params[:id])
    end

    def set_js_vars
      gon.push assets_path: url_for([:admin, @resource, :assets])
    end

    def fix_shortcode_sanitisation
      return unless Shortcode && !Shortcode.configuration.self_closing_tags.empty?
      %w(body bio description).each do |content_attribute|
        # Go to next in loop if the conditions aren't met
        next if (content = params[@resource.class.model_name.singular.to_sym][content_attribute.to_s]).nil?

        # 1. read the html output and extract the code
        # 2. Extract the occurences of shortcodes
        # 3. convert the code to encoded strings array
        # 4. search for the encoded strings with respective unsanitised plain text code
        # 5. update params hash
        #
        plain_text = Nokogiri::HTML(content).text
        short_code_chunks = []

        Shortcode.configuration.self_closing_tags.each do |short_code|
          short_code_chunks.push(*plain_text.scan(/\[#{short_code.to_s}\s+id=.+\]/).flatten.compact)
        end

        short_code_chunks.each do |short_code_chunk|
          # * Replace the escaped text with unescaped text.
          # * Replace single qoute occurences with double qoutes
          #   since short code doesnt work for single qoutes
          content.gsub! CGI.escapeHTML(short_code_chunk), short_code_chunk.tr("'", '"')
        end

        params[@resource.class.model_name.singular.to_sym][content_attribute] = content
      end
    end

    def check_authorization
      redirect_to :back, alert: t('authorization.not_authorized') unless current_user.admin? || current_user.super_admin?
    end

    def current_ability
      @current_ability ||= AdminAbility.new(current_user)
    end

    def filter_allowed_tags
      @allowed_tags = @resource_class.try('allowed_tags')
    end
  end
end
