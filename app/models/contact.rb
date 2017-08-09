class Contact < ActiveRecord::Base

  validates :email,:format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,:message => "Sorry, this doesn't look like a valid email." }
  validates :mobile_number,   :presence => {:message => 'Sorry this is not valid number'},:numericality => true,:length => { :minimum => 10, :maximum => 11 }
end
