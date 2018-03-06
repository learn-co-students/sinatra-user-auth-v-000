class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |user|
      user.string :name
      user.string :email
      user.string :password
    end
  end
end
