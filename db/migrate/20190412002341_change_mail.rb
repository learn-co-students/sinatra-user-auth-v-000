class ChangeMail < ActiveRecord::Migration
  def change
    rename_column :users, :mail, :email
  end
end
