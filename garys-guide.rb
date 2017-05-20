# garys-guide.rb
require 'nokogiri'
require 'open-uri'
require 'sinatra'

get '/' do
  erb :index
end
