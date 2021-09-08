class CreateConnections < ActiveRecord::Migration[6.1]
	def change
		create_table :connections do |t|
			t.integer :event_id
			t.integer :contact_id
			t.string :RSVP, default: "waiting for reply"

			t.timestamps
		end
		add_index :connections, :event_id
		add_index :connections, :contact_id
	end
end
