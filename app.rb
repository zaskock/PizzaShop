#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:pizzashop.db"

class Product < ActiveRecord::Base
end

before do
@products=Product.all
end

get '/' do
	erb :index
end
get '/about' do
	erb :about
end

post '/cart' do
#string to array then array to hash
	@orders=params[:orders].scan(/[0-9]+/)
	@orders.each_index{|i| i.even? ? @orders[i]=@products.find(@orders[i]) : 0}
	@orders=Hash[*@orders]
	erb :cart
end