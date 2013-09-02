class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_admin, :boolean, default: false
    add_column :users, :can_login, :boolean, default: false
    add_column :users, :user_by_email, :boolean, default: true
  end
end
