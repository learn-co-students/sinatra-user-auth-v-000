class User < ActiveRecord::Base
  # We'll validate some of the attributes of our user by writing code that makes sure no one can sign up without inputting their name, email, and password.
  validates_presence_of :name, :email, :password
end
