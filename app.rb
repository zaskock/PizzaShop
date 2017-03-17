#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:pizzashop.db"

class Product < ActiveRecord::Base
end

class Order < ActiveRecord::Base
	validates :details, presence: true
	validates :name, presence: true
	validates :phone, presence: true, length: {minimum: 10}
	validates :address, presence: true
end

before do
	@products=Product.all
	@order=Order.new
end

get '/' do
	erb :index
end
get '/about' do
	erb :about
end

get '/report' do
#listing orders in filo mode
	@orders=Order.order('created_at DESC')
#replacing a string in the details field with the hash of a form: {product_object1=>quantity_ordered1,...} for each of the orders
	@orders.each {|order| order.details=hash_from_string(order.details)}
	erb :report
end

post '/cart' do

	@orders_input=params[:orders]
	@orders=hash_from_string (@orders_input)

	erb :cart
end

post '/place_order' do

	@orders_input=params[:order][:details]
	@orders=hash_from_string (@orders_input)

	@order=Order.new params[:order]

	if @order.save
		@success= "Thank you for your choice, #{@order.name}! We'll call you ASAP! </br> Your orders' ID is #{@order.id}"
		erb :index
	else
		@error = "An error occurred, the record has not been saved to database! </br>Details: "+@order.errors.full_messages.first
	erb :cart
	end

end

def hash_from_string (s)
#if method verification ok then select series of digits from string and save as an array of strings ["1","17","2","1",...]
	s.respond_to?(:scan) ? s=s.scan(/[0-9]+/) : return
#replace each even element of an array with corresponding product object
	s.each_index{|i| i.even? ? s[i]=@products.find(s[i]) : 0}
#convert array to hash, even elements become keys
	s=Hash[*s]
return s
end