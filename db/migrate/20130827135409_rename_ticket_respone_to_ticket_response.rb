class RenameTicketResponeToTicketResponse < ActiveRecord::Migration
  def change
    rename_table :ticket_respones, :ticket_responses
  end
end
