class Another < ActiveRecord::Migration
  def self.up
    rename_column :users, :password_digest, :password
  end
end
