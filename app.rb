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
	@orders=Order.all
	@orders.each {|order| order.details=hash_from_string(order.details)}
	erb :report
end

post '/cart' do
#string to array then array to hash
	@orders_input=params[:orders]
	@orders=hash_from_string (@orders_input)
	# @orders=params[:orders].scan(/[0-9]+/)
	# @orders.each_index{|i| i.even? ? @orders[i]=@products.find(@orders[i]) : 0}
	# @orders=Hash[*@orders]
	erb :cart
end

post '/place_order' do
#string to array then array to hash
	@orders_input=params[:order][:details]
	@orders=hash_from_string (@orders_input)
	# @orders=params[:order][:details].scan(/[0-9]+/)
	# @orders.each_index{|i| i.even? ? @orders[i]=@products.find(@orders[i]) : 0}
	# @orders=Hash[*@orders]


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
	s=s.scan(/[0-9]+/)
	s.each_index{|i| i.even? ? s[i]=@products.find(s[i]) : 0}
	s=Hash[*s]
return s
end