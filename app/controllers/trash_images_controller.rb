
class TrashImagesController < ApplicationController
  before_action :set_trash_image, only: [:show, :edit, :update, :destroy]
  skip_before_filter :authenticate_user!, only: [:index, :show]
  skip_before_filter :authenticate_user_from_token!, only: [:index, :show]

  # GET /trash_images
  # GET /trash_images.json
  def index
    if params[:trash_id]
      @trash_images = TrashImage.find_by_trash_id(params[:trash_id])
    else
      @trash_images = TrashImage.all.limit(10)
    end

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

     if params[:trash_image][:temp_image]
          base64String = params[:trash_image][:temp_image]
          #create a new tempfile named fileupload
          tempfile = Tempfile.new("fileupload")
          tempfile.binmode
          #get the file and decode it with base64 then write it to the tempfile
          tempfile.write(Base64.decode64(base64String))
          #create a new uploaded file
          uploaded_file = ActionDispatch::Http::UploadedFile.new(:tempfile => tempfile, :filename => "photo.jpeg", :original_filename => "someothername.jpeg") 
          #replace picture_path with the new uploaded file
          @trash_image.trash_image =  uploaded_file
    end

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
      # format.html { redirect_to trash_images_url, notice: 'Trash image was successfully destroyed.' }
      format.json { head :no_content }
      # @trash_images = TrashImage.find_by_trash_id(@trash_image.trash_id)
      @trash = Trash.find(@trash_image.trash_id)
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trash_image
      @trash_image = TrashImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trash_image_params
      params.require(:trash_image).permit(:trash_image, :trash_id, :name, :temp_image)      
    end

   
end