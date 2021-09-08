class ChangeDefaultStateForRsvpInConnections < ActiveRecord::Migration[6.1]
  def change
    remove_column :connections, :RSVP

    add_column :connections, :RSVP, :string, null: false, default: "not-invited"
  end
end
