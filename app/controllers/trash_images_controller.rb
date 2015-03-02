
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

      the_params = params.require(:trash_image).permit(:trash_image, :trash_id, :name)
      the_params[:trash_image] = parse_image_data(the_params[:trash_image]) if the_params[:trash_image]
      the_params
    end

   def parse_image_data(base64_image)
      filename = "upload-image"
      in_content_type, encoding, string = base64_image.split(/[:;,]/)[1..3]
   
      @tempfile = Tempfile.new(filename)
      @tempfile.binmode
      @tempfile.write Base64.decode64(string)
      @tempfile.rewind
   
      # for security we want the actual content type, not just what was passed in
      content_type = `file --mime -b #{@tempfile.path}`.split(";")[0]
   
      # we will also add the extension ourselves based on the above
      # if it's not gif/jpeg/png, it will fail the validation in the upload model
      extension = content_type.match(/gif|jpeg|png/).to_s
      filename += ".#{extension}" if extension
   
      ActionDispatch::Http::UploadedFile.new({
        tempfile: @tempfile,
        content_type: content_type,
        filename: filename
      })
    end
 
  def clean_tempfile
    if @tempfile
      @tempfile.close
      @tempfile.unlink
    end
  end
end