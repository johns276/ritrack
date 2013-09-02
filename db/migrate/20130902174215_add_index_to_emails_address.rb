class AddIndexToEmailsAddress < ActiveRecord::Migration
  def change
    add_index :emails,  :address, unique: true
  end
end
