class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |table|
      table.string :name
      table.string :email
      table.string :password
    end
  end
end
