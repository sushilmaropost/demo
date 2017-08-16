class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  after_create :welcome_send

  def welcome_send
    TestMailer.welcome_mail(self).deliver     
  end 

  def random_password()
    ('a'..'z').to_a.sort_by { rand }.join[0..1]  + ('0'..'9').to_a.sort_by { rand }.join[0..6] + ('A'..'Z').to_a.sort_by { rand }.join[0..1] 
  end

  def password_required?
    if !persisted? 
      false
    else
      !password.nil? || !password_confirmation.nil?
    end
  end

end
