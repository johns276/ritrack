class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :company
      t.string :organization
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.references :user, index: true

      t.timestamps
    end
  end
end
