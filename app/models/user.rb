class User < ActiveRecord::Base
  validates_presence_of :name, :email, :password

  #validate attributes, with code so no one can sign up without inuting these three thigns.

  
end
