class User < ActiveRecord::Base
  validates_presence_of :name, :email, :password

  # attr_accessor :name, :password, :email

  # def initialize(params)
  #   @name = params["name"]
  #   @email = params["email"] 
  #   @password = params["password"] 
  # end 

end