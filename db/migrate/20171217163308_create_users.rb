class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |user|
      user.string :name
      user.string :email
      user.string :password
    end
  end
end
