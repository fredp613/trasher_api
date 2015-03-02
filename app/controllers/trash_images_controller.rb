
class TrashImagesController < ApplicationController
  before_action :set_trash_image, only: [:show, :edit, :update, :destroy]
  skip_before_filter :authenticate_user!, only: [:index, :show]
  skip_before_filter :authenticate_user_from_token!, only: [:index, :show]

  # GET /trash_images
  # GET /trash_images.json
  def index
    @trash_images = TrashImage.all
  end

  # GET /trash_images/1
  # GET /trash_images/1.json
  def show
  end

  # GET /trash_images/new
  def new
    @trash_image = TrashImage.new
  end

  # GET /trash_images/1/edit
  def edit
  end

  # POST /trash_images
  # POST /trash_images.json
  def create
         
    @trash_image = TrashImage.new(trash_image_params)
    @trash_image.created_by = current_user.id
    @trash_image.updated_by = current_user.id 

    respond_to do |format|
      if @trash_image.save
        format.html { redirect_to trash_images_url, notice: 'Trash image was successfully created.' }
        format.json { render :show, status: :created, location: @trash_image }
      else
        format.html { render :new }
        format.json { render json: @trash_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trash_images/1
  # PATCH/PUT /trash_images/1.json
  def update
    @trash_image.updated_by = current_user.id 
    respond_to do |format|
      if @trash_image.update(trash_image_params)
        format.html { redirect_to @trash_image, notice: 'Trash was successfully updated.' }
        format.json { render :show, status: :ok, location: @trash_image }
      else
        format.html { render :edit }
        format.json { render json: @trash_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trash_images/1
  # DELETE /trash_images/1.json
  def destroy
    @trash_image.destroy
    respond_to do |format|
      format.html { redirect_to trash_images_url, notice: 'Trash image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trash_image
      @trash_image = TrashImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trash_image_params
      params.require(:trash_image).permit(:trash_image, :trash_id, :name)      
    end

   
end