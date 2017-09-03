class User < ActiveRecord::Base
  validates_presence_of :name, :email, :password
  # validate attributes so that no one can signup without name, email and password
end
