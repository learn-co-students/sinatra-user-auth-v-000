class User < ActiveRecord::Base
  validates_presence_of :name, :email, :password

  attr_accessor :name, :email, :password
end
