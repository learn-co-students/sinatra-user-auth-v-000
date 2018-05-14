class CreateUser < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |s|
      s.string :name
      s.string :email
      s.string :password
    end
  end
end