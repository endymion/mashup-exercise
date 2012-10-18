require 'rubygems'
require 'bundler'

require 'sinatra'
require_relative 'tourdate'

get '/' do
  dates = TourDate.get_dates
  threads = dates.map do |date|
    Thread.new do
      date.get_weather
    end
  end
  threads.each {|thread| thread.join }
  haml :index, :locals => {:dates => dates}
end

get "/css/:sheet.css" do |sheet|
  sass :"sass/#{sheet}"
end