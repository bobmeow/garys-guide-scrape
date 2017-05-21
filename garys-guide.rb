# garys-guide.rb
require 'nokogiri'
require 'open-uri'
require 'sinatra'
require './models/script'

get '/' do
  @jobs = getJobs
  erb :index
end
