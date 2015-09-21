module Admin
  # Pages Add/Edit/Delete
  class BannersController < ApplicationController
  layout 'admin'
  before_action :set_banner, only: [:show, :edit, :update, :destroy]

  # GET /banners
  # GET /banners.json
  def index
    @resources = Banner.all
  end

  # GET /banners/1
  # GET /banners/1.json
  def show
  end

  # GET /banners/new
  def new
    #@banner = Banner.new
    @banner = Banner.create
    @banner.update_attribute(:slug, @banner.id)
    respond_to do |format|
        format.html { render :edit }
        format.json { render :show, status: :ok, location: @banner }
    end
  end

  # GET /banners/1/edit
  def edit
  end

  # # POST /banners
  # # POST /banners.json
  # def create
  #   @banner = Banner.new(banner_params)

  #   respond_to do |format|
  #     if @banner.save
  #       format.html { redirect_to 'admin/banners/', notice: 'Banner was successfully created.' }
  #       format.json { render :show, status: :created, location: @banner }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @banner.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # PATCH/PUT /banners/1
  # # PATCH/PUT /banners/1.json
  # def update
  #   respond_to do |format|
  #     if @banner.update(banner_params)
  #       format.html { redirect_to 'admin/banners/', notice: 'Banner was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @banner }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @banner.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def create
      @banner = Banner.new(banner_params)
      respond_to do |format|
        if @banner.save
          format.html { render :edit }
          format.json { render :show, status: :created, location: @banner }
        else
          format.html { render :new }
          format.json { render json: @banner.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @banner.update(banner_params)
          if params[:button] == 'publish' #&& @banner.state != 'published'
            @banner.publish
          elsif params[:button] == 'save_draft' #&& @banner.state != 'save_draft'
            @banner.save_draft
          end
          #
          format.html { render :edit, notice: t('common.messages.updated', resource_class_name: Banner) }
          format.json { render :show, status: :ok, location: @banner }
        else
          format.html { render :edit }
          format.json { render json: @banner.errors, status: :unprocessable_entity }
        end
      end
    end

  # DELETE /banners/1
  # DELETE /banners/1.json
  # def destroy
  #   @banner.destroy
  #   respond_to do |format|
  #     format.html { redirect_to 'admin/banners/', notice: 'Banner was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  def destroy
      if @banner.destroy
        flash[:info] = t('common.messages.deleted', resource_class_name: @resource_class_name)
      else
        flash[:danger] = @banner.errors.full_messages.to_sentence
      end

      respond_to do |format|
        format.html { redirect_to 'admin/banners/' }
        format.json { head :no_content }
      end
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_banner
      @banner = Banner.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def banner_params
      params.require(:banner).permit(:line_1,:line_2,:line_3,:title,:slug)
    end
  end
end