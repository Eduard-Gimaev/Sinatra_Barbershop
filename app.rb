#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def get_db
	db = SQLite3::Database.new 'barbershop.db'
	db.results_as_hash = true
	return db
end

configure do 
	get_db = SQLite3::Database.new 'barbershop.db'
	db = get_db
	db.execute 'CREATE TABLE IF NOT EXISTS 
    "Clients" 
    (
        "id" INTEGER PRIMARY KEY AUTOINCREMENT,
        "username" text(128),
        "phone" text(128),
        "datestamp" text(128),
        "barber" text(128),
        "color" text(128)
    )'

	db.execute 'CREATE TABLE IF NOT EXISTS 
		"Barbers" 
		(
			"ID" integer PRIMARY KEY AUTOINCREMENT NOT NULL,
			"barbername" text(128)
		)'
	db.execute 'CREATE TABLE IF NOT EXISTS 
		"Contacts" 
		(
			"ID" integer PRIMARY KEY AUTOINCREMENT NOT NULL,
			"username" text(128),
			"usermessage" text(128)
		)'
end

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do
	erb :about
end

get '/visit' do
	erb :visit
end  

post '/visit' do
	@username = params[:username]
	@phone = params[:phone]
	@datetime = params[:datetime]
	@barber = params[:barber]
	@color = params[:colorpicker]

	hh = {  :username => 'Insert your name',
			:phone => 'Insert phone number',
			:datetime => 'Insert date and time'}

	@error = hh.select {|key,_| params[key] == ''}.values.join(", ")
	if @error !=''
		return erb :visit
	end
	
	db = get_db
	db.execute 'insert into Clients
	(username, phone, datestamp, barber, color)
	values(?, ?, ?, ?, ?)',
	[@username, @phone, @datetime, @barber, @color]

	erb "You has been enrolled, please check your data: #{@username}, #{@phone}, #{@datetime}, #{@barber}, #{@color}"
end  



get '/contacts' do
	erb :contacts
end

post '/contacts' do
	@username = params[:username]
	@usermessage = params[:usermessage]
	
	erb "Your message has been accepted, we'll call you back soon..."
end  

get '/showusers' do
	
	erb :showusers
  end
  