class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :description
      t.boolean :completed
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
