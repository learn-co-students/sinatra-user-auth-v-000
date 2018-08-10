# To create this file, run $ rake db:create_migration NAME=create_users_table.
# Then add the create_table block. Then run db:migrate to create in database.

class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
    end

  end
end
