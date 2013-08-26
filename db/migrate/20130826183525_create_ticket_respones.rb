class CreateTicketRespones < ActiveRecord::Migration
  def change
    create_table :ticket_respones do |t|
      t.text :body
      t.datetime :response_sent
      t.references :ticket, index: true

      t.timestamps
    end
  end
end
