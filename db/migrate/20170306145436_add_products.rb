class AddProducts < ActiveRecord::Migration
	def change
		Product.create :title => 'Hawaiian', :description => 'A classical Hawaiian pizza', :price => 14, :size => 30, :is_spicy => false, :is_veg => false, :is_best_offer => false, :path_to_image => '/images/hawaiian.jpg'

		Product.create :title => 'Pepperony', :description => 'A classical Pepperony pizza', :price => 11, :size => 30, :is_spicy => true, :is_veg => false, :is_best_offer => true, :path_to_image => '/images/pepperoni.jpg'

		Product.create :title => 'Vegetarian', :description => 'A classical Vegeterian pizza', :price => 14, :size => 30, :is_spicy => false, :is_veg => true, :is_best_offer => false, :path_to_image => '/images/veg.jpg'
	end
end
