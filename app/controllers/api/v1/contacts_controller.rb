class Api::V1::ContactsController < ApplicationController
  respond_to :json
  skip_before_action :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }


  def create
    if params["data"].present? and params["data"]["contact"].present?
      data = Contact.create_contacts(params["data"])
      render :json => {:contact => data }
    else
      render :status => 500, :json => {:status => "Failure", :message => "Provide data for create contact us."}
    end
  end
end

