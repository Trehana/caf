module Common
  extend ActiveSupport::Concern

  included do
    before_action :set_resource_class_name
    before_action :set_resource_class
    before_action :set_resource, only: [:show, :edit, :update, :destroy]
    before_action :set_html_variables, only: [:show]
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
  end

  # GET /pages/new
  def new
    @resource = @resource_class.create
    respond_to do |format|
      format.html { render :edit }
      format.json { render :show, status: :ok, location: @resource }
    end
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages
  # POST /pages.json
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

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
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

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @resource.move_to_trash
    respond_to do |format|
      format.html { redirect_to @resource_index_path, notice: t('page.messages.deleted') }
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

  def set_html_variables
    @body_class = @resource_class.name.underscore unless defined?(@body_class)
    set_meta_tags   title: @resource.try(:title) && !@resource.try(:title).empty? ? "#{@resource.try(:title)} | #{t('meta_tags.title')}" : "#{t('meta_tags.title')}",
                    description: t('meta_tags.description'),
                    keywords: "#{t('meta_tags.keywords')}#{@resource.try(:meta_tags) && !@resource.try(:meta_tags).empty? ? ', ' + @resource.try(:meta_tags) : ''}".squish
  end
  #
end
