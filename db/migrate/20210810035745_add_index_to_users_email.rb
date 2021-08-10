class AddIndexToUsersEmail < ActiveRecord::Migration[6.1]
  def change
    add_index :users, :email, unique: true #use Rails method 'add_index' table, column, attribute
  end
end
