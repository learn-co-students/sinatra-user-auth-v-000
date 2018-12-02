class CreateUsers < ActiveRecord::Migration
  def change
    User.reset_column_information
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
    end
  end
end
