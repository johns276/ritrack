class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name_string
      t.string :nick_name
      t.string :login_name
      t.text :notes

      t.timestamps
    end
  end
end
