class ChangeColumnFromCompletedToCheckedInTasks < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :completed

    add_column :tasks, :checked, :boolean, null: false, default: false
  end
end
