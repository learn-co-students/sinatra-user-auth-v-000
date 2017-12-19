class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |u| #pluralized for the table
        u.string :name
        u.string :email
        u.string :password
    end
  end
end


#to create this file in terminal type 'rake db:create_migration NAME=create_users'
#to run this migration and setup the db run in terminal "rake db:migrate"
