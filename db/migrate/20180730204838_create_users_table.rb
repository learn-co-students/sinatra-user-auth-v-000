class CreateUsersTable < ActiveRecord::Migration
  def change
		create_table :products do |t|
			t.string :name
			t.string :email
			t.string :password
		end
  end
end
