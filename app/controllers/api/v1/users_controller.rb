class Api::V1::UsersController < ApplicationController

respond_to :json
skip_before_action :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
#before_action :authenticate_request!

  def create
    if params["data"].present? and params["data"]["user"].present?
      data = User.create_users(params["data"])
      render :json => {:user => data }
    else
      render :status => 500, :json => {:status => "Failure", :message => "Provide valid data for creating user."}
    end
  end

end
