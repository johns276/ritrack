class CreateTicketObservers < ActiveRecord::Migration
  def change
    create_table :ticket_observers do |t|
      t.references :user, index: true
      t.references :ticket, index: true
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
