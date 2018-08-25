class User < ActiveRecord::Base #rake db:create_migration NAME=create_users_table
  validates_presence_of :name, :email, :password
end