class Gallery < ActiveRecord::Base
  
  require 'csv'
  require 'open-uri'
  # validate :avatar_size_validation
   mount_uploader :file, AvatarUploader
   validates :title, presence: true,uniqueness: true
   validates :file, presence: true, on: :create

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      image = row['file']
      g = Gallery.new
      g.remote_file_url = image
      g.title = row['title']
      g.save!
    end 
 end

  private

  def avatar_size_validation
    errors[:avatar] << "should be less than 5MB" if photo.size > 5.megabytes
  end  
end
