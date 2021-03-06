class GalleriesController < ApplicationController
  before_action :set_photos, only: [:show, :edit, :update, :destroy]
  before_action :get_collection, only: [:update,:index] 
  before_action :authenticate_user!
  skip_before_filter :verify_authenticity_token#, :only => [:index, :show]
  


  def index

  end

  def import
    begin
      if Gallery.check_header(params[:file])
        message = Gallery.import(params[:file],current_user.id) 
        # redirect_to galleries_path, notice: "Images are imported."
        redirect_to galleries_path, notice: message
      else
        redirect_to galleries_path, notice: "Please set the Header in CSV file"
      end
    rescue
      redirect_to galleries_path, notice: "Invalid CSV file format/No file choosen"
    end
  end

  
  def show
  end


  def counter
    @count = Gallery.where("user_id" => current_user.id).count
    respond_to do |format|
      format.json { render json: @count}
    end
  end

  
  def new
    @gallary = Gallery.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  
  def edit
  end

 
  def create
    @gallary = Gallery.new(gallery_params)
      if @gallary.save
        redirect_to galleries_path, notice: 'Image was successfully created.'
      else
        render :new ,notice:  'Sorry we cannot add this Image.'
      end
  end

  
  def update
    if @gallary.update_attributes(gallery_params) 
      respond_to do |format|
        format.html { redirect_to galleries_path, notice: 'Image was successfully updated.' }
        format.js 
      end 
    else 
      respond_to do |format|
        format.html{ render :edit, :locals => {:gallary => @gallary}}
        format.js{ }
      end  
    end
  end

  
  def destroy
    @gallary = Gallery.find(params[:id])
    @gallary.destroy
    redirect_to galleries_path
    # respond_to do |format|
    #   format.html {
    #     flash[:success] = 'Image was successfully destroyed.'
    #     redirect_to galleries_path
    #   }
    #   format.json { head :no_content }
    # end
  end


  private
    
    def get_collection
      @galleries = Gallery.where("user_id" => current_user.id).page(params[:page]).per(3)
    end

    def set_photos
      @gallary = Gallery.find(params[:id])
    end

    
    def gallery_params
      params.require(:gallery).permit!#(:title, :file)
    end
end
