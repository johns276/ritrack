class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :number
      t.string :tag
      t.references :user, index: true

      t.timestamps
    end
    add_index :phones, :number
  end
end
