class TrashesController < ApplicationController
  before_action :set_trash, only: [:show, :edit, :update, :destroy]
  skip_before_filter :authenticate_user!, only: [:index, :index_api, :show]
  skip_before_filter :authenticate_user_from_token!, only: [:index, :index_api, :show] 
  # GET /trashes
  # GET /trashes.json
  def index
    
    if params[:trash_type]
      if params[:trash_type] == "Wanted"
        @trash = Trash.wanted.order(:created_at => :desc).page(params[:page]).per(20)
      else
        @trash = Trash.rid.order(:created_at => :desc).page(params[:page]).per(20)
      end
    else
      @trash = Trash.wanted.order(:created_at => :desc).page(params[:page]).per(20)        
    end
   
    respond_to do |format|
      format.html { }
      format.json { render json: @trash }
      format.js
    end   
  end

  def index_api 
    @wanted_trash = Trash.wanted.order(:created_at => :desc).page(params[:page]).per(20)
    @rid_trash = Trash.rid.order(:created_at => :desc).page(params[:page]).per(20)
    @trash = @wanted_trash + @rid_trash

    respond_to do |format|      
      format.json { render json: @trash, :include => :first_image }      
    end 

  end

  def user_index
   
    @trash = Trash.where(created_by: current_user.id).order(:updated_at => :desc)
    respond_to do |format|
      format.html { }
      format.json { render json: @trash }
      format.js
    end
  end

  # GET /trashes/1
  # GET /trashes/1.json
  def show
  end

  # GET /trashes/new
  def new
    @trash = Trash.new
    @trash.temp_id = ('a'..'z').to_a.shuffle[0,8].join    
  end

  # GET /trashes/1/edit
  def edit
  end

  # POST /trashes
  # POST /trashes.json
  def create
    @trash = Trash.new(trash_params) 
    @trash.created_by = current_user.id
    @trash.updated_by = current_user.id  
     
    respond_to do |format|
      if @trash.save                       
        toggle_temp_images #unless params[:trash][:temp_id].blank?
        format.html { redirect_to @trash, notice: 'Trash was successfully created.' }
        format.json { render :show, status: :created, trash: @trash }
        # format.js
      else
        format.html { render :new }
        format.json { render json: @trash.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trashes/1
  # PATCH/PUT /trashes/1.json
  def update
    @trash.updated_by = current_user.id
    
    user_auth_token = request.headers["X-API-TOKEN"].presence
    if user_auth_token
      if params[:trash][:images] == true 
        existing_images = TrashImage.where(trash_id: @trash.id)
        if existing_images 
          existing_images.destroy_all
        end
      end
    end

    respond_to do |format|
      if @trash.update(trash_params)       
        toggle_temp_images #unless params[:trash][:temp_id].blank?
        format.html { redirect_to @trash, notice: 'Trash was successfully updated.' }
        format.json { render :show, status: :ok, location: @trash }
      else
        format.html { render :edit }
        format.json { render json: @trash.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trashes/1
  # DELETE /trashes/1.json
  def destroy
    @trash.destroy
    respond_to do |format|
      format.html { redirect_to trashes_url, notice: 'Trash was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trash
      @trash = Trash.find(params[:id])
    end


    def set_trash_collection
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def trash_params
      params.require(:trash).permit(:title, :description, :catetory_id, :trash_type, :images, :temp_id)
    end

  def toggle_temp_images
    @temp_images = TempImage.find_by_temp_id(@trash.temp_id)
    unless @temp_images.blank?
      @temp_images.each do |ti|            
        @trash.trash_images.create(trash_image: ti.image, name: ti.name)                  
      end
      @temp_images.each do |ti|
        ti.destroy
      end
    end
  end
end
