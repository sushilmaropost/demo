class PygmentsWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(type,id,password)
    if type.present?
      if type == "user"
        TestMailer.welcome_mail(id,password).deliver_later 
      elsif type == "contact"
        TestMailer.contact_us(id).deliver_later
      end
    end
    # TestMailer.welcome_mail().deliver_later  
  end
end