class User < ActiveRecord::Base
  validates_presence_of :name, :email, :password, presence: true

end
