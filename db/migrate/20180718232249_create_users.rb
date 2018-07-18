class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :name
      t.string :email
      t.string :password
  end
end
end
