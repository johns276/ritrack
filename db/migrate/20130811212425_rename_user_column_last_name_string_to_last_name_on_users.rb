class RenameUserColumnLastNameStringToLastNameOnUsers < ActiveRecord::Migration
  def change
    rename_column :users, :last_name_string, :last_name
  end
end
