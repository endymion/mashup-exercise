require 'rubygems'
require 'bundler'

require 'sinatra'

get '/' do
  haml :index
end

get "/css/:sheet.css" do |sheet|
  sass :"sass/#{sheet}"
end