class AddDefaultValueToNotesInEvents < ActiveRecord::Migration[6.1]
  def change
    remove_column :events, :notes

    add_column :events, :notes, :text, default: ""
  end
end
