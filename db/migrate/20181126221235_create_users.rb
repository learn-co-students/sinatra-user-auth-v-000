class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |i|
      i.string :name
      i.string :email
      i.string :password
    end
  end
end
