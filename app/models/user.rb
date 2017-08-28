class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable#,:async


  after_create :welcome_send

  def welcome_send
    #TestMailer.welcome_mail(self).deliver 
    #TestMailer.welcome_mail(self).deliver_later 
    PygmentsWorker.perform_async("user",self.id,self.password) 
  end 

  def random_password()
    ('a'..'z').to_a.sort_by { rand }.join[0..1]  + ('0'..'9').to_a.sort_by { rand }.join[0..6] + ('A'..'Z').to_a.sort_by { rand }.join[0...1] 
  end

  def password_required?
    if !persisted? 
      false
    else
      !password.nil? || !password_confirmation.nil?
    end
  end


  def self.create_user_through_api(value)
    random_password = ('a'..'z').to_a.sort_by { rand }.join[0..1]  + ('0'..'9').to_a.sort_by { rand }.join[0..6] + ('A'..'Z').to_a.sort_by { rand }.join[0...1] 
    user = User.new(email:value["email"],password:random_password,password_confirmation:random_password)
    err=[]
    if user.save
      err <<  {:status => 'Success', :user => user.as_json() ,:message => 'User create successfully.' ,:code => '200'}
      return err
    else
      err << {errors: user.errors, :status => "Failure",:code => '500'}
      return err
    end
  end

  def self.create_users(users)
    message = []
    users["user"].each do |value|
      u = User.create_user_through_api(value)
      message << u
    end
    return message
  end
end
