class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |c|
      c.string :name
      c.string :email
      c.string :password
    end
  end
end
