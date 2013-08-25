class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_admin, :boolean
    add_column :users, :can_login, :boolean
    add_column :users, :user_by_email, :boolean
  end
end
