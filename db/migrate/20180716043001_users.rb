class Users < ActiveRecord::Migration[5.2]
<<<<<<< HEAD
  def change
    create_table :users do|t|
=======
  def create_table user do |t|
>>>>>>> a70b9b505f25fa36f3c4573a64c24b0cefd3ef15
      t.string :name
      t.string :email
      t.string :password
    end
  end
end
