class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |u|
      u.string :name
      u.string :email
      u.string :password
    end
  end
 
  def down
    drop_table :users
  end
end
