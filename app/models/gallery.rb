class Gallery < ActiveRecord::Base
  
  require 'csv'
  require 'open-uri'
  # validate :avatar_size_validation
  mount_uploader :file, AvatarUploader
  #validates :title, presence: true,uniqueness: true
   
  default_scope  { order(:created_at => :desc) }
  validates :title, presence: true,:uniqueness => {:scope=>:user_id}
  validates :file, presence: true, on: :create


  def self.check_header(file)
    title = ["TITLE","Title","title"]
    fille = ["FILE","File","file"]
    field = CSV.read(file.path)
    check_header = nil
    field.each_with_index do |f,i|
      if i == 0
        check_header = (((title.include?(f[0])) or (title.include?(f[1]))) and ((fille.include?(f[0])) or (fille.include?(f[1]))))
      end
    end if field.present?
    return true if check_header
  end

  def self.import(file,current_user_id) 
    #CSV.open(file.path, skip_blanks: true, headers: true).reject { |row| row.to_hash.values.all?(&:nil?) }
    data_present = (CSV.readlines(file.path, skip_blanks: true, headers: true).reject { |row| row.to_hash.values.all?(&:nil?) } != [] ? true : false)
    if data_present
      message = nil
      CSV.foreach(file.path, headers: true) do |row|
        image = row['file']
        g = Gallery.new
        g.remote_file_url = image
        g.title = row['title']
        g.user_id = current_user_id
        if g.save #g.save!
          message = "Images are imported."
        else
          message = g.errors.full_messages[0] if g.errors.present?
        end
      end 
      return message
    else
      message = "There is no data in file."
      return message
    end
  end

  def image_url
    self.file.url
  end

  def self.create_images_through_api(value,user_id)
    gallery = Gallery.new(title:value["title"],remote_file_url:value["remote_file_url"],user_id:user_id)
    err=[]
    if gallery.save
      err <<  {:status => 'Success', :gallery => gallery.as_json() ,:message => 'Image saved successfully.' ,:code => '200'}
      return err
    else
      err << {errors: gallery.errors, :status => "Failure",:code => '500'}
      return err
    end
  end

  def self.create_images(images,user_id)
    message = []
    images["gallery"].each do |value|
      g = Gallery.create_images_through_api(value,user_id)
      message << g
    end
    return message
  end


  private

  def avatar_size_validation
    errors[:avatar] << "should be less than 5MB" if photo.size > 5.megabytes
  end  
end
