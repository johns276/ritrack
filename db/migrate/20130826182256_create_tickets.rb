class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :subject
      t.string :status
      t.integer :priority
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :due_date
      t.references :user, index: true
      t.references :ticket_queue, index: true

      t.timestamps
    end
  end
end
