class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t| #from dog example in activerecord setup in sinatra
      t.string :name
      t.string :email
      t.string :password
    end
  end
end
