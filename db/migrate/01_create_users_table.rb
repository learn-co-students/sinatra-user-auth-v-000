class CreateUsersTable < ActiveRecord::Migration
  
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :email
    end # end of change
  end # end of definition
  
end