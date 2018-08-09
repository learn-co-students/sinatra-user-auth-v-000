class User < ActiveRecord::Base
  validates_presence_of :name, :email, :password
  
    def change
    create_table :user do |t|
      t.string :name
      t.string :email
      t.string :password
    end
  end
end