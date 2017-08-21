class Contact < ActiveRecord::Base

  validates :email,:format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,:message => "Sorry, this doesn't look like a valid email." }
  validates :mobile_number,   :presence => {:message => 'Sorry this is not valid number'},:numericality => true,:length => { :minimum => 10, :maximum => 10 }

  def self.create_contact_through_api(value)
    contact = Contact.new(name:value["name"],email:value["email"],mobile_number:value["mobile_number"],message:value["message"])
    err=[]
    if contact.save
      TestMailer.contact_us(contact).deliver
      err <<  {:status => 'Success', :contact => contact.as_json() ,:message => 'Request is submitted successfully.' ,:code => '200'}
      return err
    else
      err << {errors: contact.errors, :status => "Failure",:code => '500'}
      return err
    end
  end

  def self.create_contacts(contacts)
    message = []
    contacts["contact"].each do |value|
      c = Contact.create_contact_through_api(value)
      message << c
    end
    return message
  end
end
