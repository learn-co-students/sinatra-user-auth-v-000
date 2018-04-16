class User < ActiveRecord::Base
  validates_presence_of :name, :email, :password

end
# we dont have to create and initalize because ActiveRecord does the create for us.
