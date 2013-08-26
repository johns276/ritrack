class CreateTicketQueues < ActiveRecord::Migration
  def change
    create_table :ticket_queues do |t|
      t.string :name
      t.string :description
      t.string :url
      t.integer :priority
      t.integer :default_due_in
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
