class TestMailer < ApplicationMailer
  default from: "testmailmaropost@gmail.com"

  def welcome_mail(user)
    @user = user
    mail to: @user.email, subject: 'Welcome Email'

    # mail to: user.email, subject: "welcome to my gallery" , from: "bodharth@maropost.com"  
  end

  def contact_us(contact)
    @contact = contact
    mail to: @contact.email, subject: 'Contact us Acknowledgement'
  end

end
