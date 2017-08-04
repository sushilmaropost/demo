class ContactsController < ApplicationController
  before_action :authenticate_user!
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params_contact)
    if @contact.save
      TestMailer.contact_us(@contact).deliver
      redirect_to root_path
    else
     render 'new'
    end
    # @contact.request = request
    # if @contact.deliver
    #   flash.now[:notice] = 'Thank you for your message. We will contact you soon!'
    #   render :new
    # else
    #   flash.now[:error] = 'Please fill proper imformation'
    #   render :new
    # end
  end 

  private
  def params_contact
    params.require(:contact).permit!
  end
end
