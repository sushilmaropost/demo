class Api::V1::GalleriesController < ApplicationController

  respond_to :json
  skip_before_action :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
  #before_action :authenticate_request!


  def index
    if params[:user_id].present?
      galleries = Gallery.where("user_id" => params[:user_id])
      if galleries.present?
        render :json => {:status => 'Success',:message => 'Images fetched successfully.' ,:code => '200', :gallery => galleries.as_json(:only => [:title],:methods => [:image_url]) }
      else
        render :status => 500, :json => {:status => "Failure", :message => "This User is not having any images."}
      end
    else
      render :status => 500, :json => {:status => "Failure", :message => "Provide User id for getting images."}
    end
  end

  # def create
  #   if params[:user_id].present?
  #     params["data"]["gallery"].each do |value|
  #       gallery = Gallery.new(title:value["title"],remote_file_url:value["remote_file_url"],user_id:params[:user_id]) 
  #       if gallery.save 
  #         render :json => { :status => 'success', :gallery => gallery.as_json() ,:message => 'Image saved successfully.' ,:code => '200'}
  #       else
  #         render json: { errors: gallery.errors}, status: 500 , message: 'failed'
  #       end
  #     end
  #   else
  #     render :status => 500, :json => {:status => "Failure", :message => "Provide User id for Saving images."}
  #   end
  # end

  def create
    if params[:user_id].present?
      if params["data"].present? and params["data"]["gallery"].present?
        data = Gallery.create_images(params["data"],params[:user_id])
        render :json => {:gallery => data }
      else
        render :status => 500, :json => {:status => "Failure", :message => "Provide proper data for create images."}
      end
    else
      render :status => 500, :json => {:status => "Failure", :message => "Provide User id for Saving images."}
    end
  end

end