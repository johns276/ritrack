class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :subject
      t.datetime :start_date
      t.date :due_date
      t.datetime :end_date
      t.text :notes
      t.references :ticket, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
