class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.string :email
      t.string :phone
      t.string :notes
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
