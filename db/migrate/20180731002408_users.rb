class Users < ActiveRecord::Migration
  create_table :users do |t|
    t.string :name
    t.string :email
    t.string :password
  end
end
