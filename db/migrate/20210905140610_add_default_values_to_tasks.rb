class AddDefaultValuesToTasks < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :description
    remove_column :tasks, :completed

    add_column :tasks, :description, :string, null: false
    add_column :tasks, :completed, :boolean, null: false, default: false

  end
end
