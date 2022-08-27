#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end
get '/about' do
	erb :about
  end

  get '/visit' do
	erb :visit
  end  

  get '/contacts' do
	erb :contacts
  end

  post '/visit' do
	@username = params[:username]
	@phone = params[:phone]
	@datetime = params[:datetime]
	@barber = params[:barber]
	
	erb "You has beem enrolled, please check your data: #{@username},#{@phone}, #{@datetime},#{@barber}"
  end  

  
