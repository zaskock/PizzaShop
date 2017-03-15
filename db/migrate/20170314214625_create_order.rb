class CreateOrder < ActiveRecord::Migration
	def change
		create_table :orders do |t|
			t.string :details
			t.string :name
			t.string :phone
			t.string :address
			t.timestamps null: false
		end
	end
end
