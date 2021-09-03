class AddPlaceToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :place, :string
  end
end
