# Change Username to User
class ChangeUsernameToName < ActiveRecord::Migration
  def change
    rename_column :users, :username, :name
  end
end
