class TestMailer < ApplicationMailer
  default from: "testmailmaropost@gmail.com"

  # def welcome_mail(user)
  #   @user = user
  #   mail to: @user.email, subject: 'Welcome Email'
  # end

  def welcome_mail(id,password)
    @user = User.find_by_id(id)
    @password = password
    mail to: @user.email, subject: 'Welcome Email'
  end

  # def contact_us(contact)
  #   @contact = contact
  #   mail to: @contact.email, subject: 'Contact us Acknowledgement'
  # end

  def contact_us(id)
    @contact = Contact.find_by_id(id)
    mail to: @contact.email, subject: 'Contact us Acknowledgement'
  end

end
