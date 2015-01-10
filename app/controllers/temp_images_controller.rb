class TempImagesController < ApplicationController
  before_action :set_temp_image, only: [:show, :edit, :update, :destroy]

  # GET /temp_images
  # GET /temp_images.json
  def index
    @temp_images = TempImage.all
  end

  # GET /temp_images/1
  # GET /temp_images/1.json
  def show
  end

  # GET /temp_images/new
  def new
    @temp_image = TempImage.new
  end

  # GET /temp_images/1/edit
  def edit
  end

  # POST /temp_images
  # POST /temp_images.json
  def create
      @temp_image = TempImage.create(temp_image_params) 
  end

  # PATCH/PUT /temp_images/1
  # PATCH/PUT /temp_images/1.json
  def update
    respond_to do |format|
      if @temp_image.update(temp_image_params)
        format.html { redirect_to @temp_image, notice: 'Temp image was successfully updated.' }
        format.json { render :show, status: :ok, location: @temp_image }
      else
        format.html { render :edit }
        format.json { render json: @temp_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /temp_images/1
  # DELETE /temp_images/1.json
  def destroy
    @temp_image.destroy
    respond_to do |format|
      format.html { redirect_to temp_images_url, notice: 'Temp image was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_temp_image
      @temp_image = TempImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def temp_image_params
      params.require(:temp_image).permit(:image, :temp_id)
    end
end
