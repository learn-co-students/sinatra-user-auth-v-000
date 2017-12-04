class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |col|
      col.text :name
      col.text :email
      col.text :password
    end
  end
end
