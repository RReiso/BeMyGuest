class CreateConnections < ActiveRecord::Migration[6.1]
	def change
		create_table :connections do |t|
			t.integer :event_id
			t.integer :contact_id
			t.string :RSVP

			t.timestamps
		end
		add_index :connections, :event_id
		add_index :connections, :contact_id
		add_index :connections, %i[event_id contact_id], unique: true
	end
end
