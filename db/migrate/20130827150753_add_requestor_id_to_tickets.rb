class AddRequestorIdToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :requestor_id, :integer
    add_index :tickets, :requestor_id
  end
end
