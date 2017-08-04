class Contact < ActiveRecord::Base

  #validates :email,:format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,:message => "Sorry, this doesn't look like a valid email." }
end
