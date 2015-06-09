module Admin
  module Common
    extend ActiveSupport::Concern

    included do
      before_action :set_resource_class_name
      before_action :set_resource_class
      before_action :set_resource, only: [:show, :edit, :update, :destroy]
      before_action :set_js_vars, only: [:edit, :update, :destroy]
      before_action :fix_shortcode_sanitisation, only: [:update]
    end

    def index
      @resources = @resource_class.editors_content
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
          format.html { redirect_to @resource, notice: 'Page was successfully created.' }
          format.json { render :show, status: :created, location: @resource }
        else
          format.html { render :new }
          format.json { render json: @resource.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        resource_singular_name = @resource.class.model_name.singular
        if @resource.update(resource_params)
          if params[:button] == 'publish' && @resource.state != 'published'
            @resource.publish
          elsif params[:button] == 'save_draft' && @resource.state != 'save_draft'
            @resource.save_draft
          end
          #
          format.html { render :edit, notice: t("#{resource_singular_name}.messages.updated") }
          format.json { render :show, status: :ok, location: @resource }
        else
          format.html { render :edit }
          format.json { render json: @resource.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @resource.move_to_trash
      respond_to do |format|
        format.html { redirect_to @resource_index_path, notice: t("#{resource_singular_name}.messages.deleted") }
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
      if Shortcode && !Shortcode.configuration.self_closing_tags.empty?
        %w(body bio).each do |content_attribute|
          if params[@resource.class.model_name.singular.to_sym].key?(content_attribute.to_s)
            content = params[@resource.class.model_name.singular.to_sym][content_attribute]
            # 1. read the html output and extract the code
            plain_text = Nokogiri::HTML(content).text
            # 2. Extract the occurences of shortcodes
            # 3. convert the code to encoded strings array
            short_code_chunks = []
            Shortcode.configuration.self_closing_tags.each do |short_code|
              short_code_chunks.push(*plain_text.scan(/\[#{short_code.to_s}\s+id=.+\]/).flatten.compact)
            end
            short_code_chunks_to_html_hash = {}
            short_code_chunks.each do |short_code_chunk|
              short_code_chunks_to_html_hash[short_code_chunk] = CGI.escapeHTML(short_code_chunk)
            end
            # 4. search for the encoded strings with respective unsanitised plain text code
            short_code_chunks_to_html_hash.each do |short_code, short_code_html|
              content.gsub! short_code_html, short_code
            end
            # 5. update params hash
            params[@resource.class.model_name.singular.to_sym][content_attribute] = content
          end
        end
      end
    end
  end
end
