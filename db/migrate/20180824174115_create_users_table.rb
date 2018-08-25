class CreateUsersTable < ActiveRecord::Migration #rake db:create_migration NAME=create_users_table
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
    end
  end
end


# how to create migration table in sinatra
#https://gist.github.com/jtallant/fd66db19e078809dfe94401a0fc814d2