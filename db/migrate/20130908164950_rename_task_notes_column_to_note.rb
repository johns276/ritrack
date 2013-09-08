class RenameTaskNotesColumnToNote < ActiveRecord::Migration
  def change
    rename_column :tasks, :notes, :note
  end
end
