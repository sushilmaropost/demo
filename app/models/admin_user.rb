class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  after_save :create_record_in_user
  after_destroy :destroy_record_in_user

  def create_record_in_user
    user = User.new
    user.email = self.email
    user.password = self.password
    user.password_confirmation = self.password_confirmation
    if user.save
      TestMailer.welcome_mail(user).deliver
    end
  end

  def destroy_record_in_user
    user = User.find_by_email(self.email)
    if user.present?
      user.destroy
    end
  end
end
