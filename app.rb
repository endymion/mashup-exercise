require 'rubygems'
require 'bundler'

require 'sinatra'
require_relative 'event'

get '/' do
  events = Event.get_events
  threads = events.map do |event|
    Thread.new do
      event.get_weather
    end
  end
  threads.each {|thread| thread.join }
  haml :index, :locals => {:events => events}
end

get "/css/:sheet.css" do |sheet|
  sass :"sass/#{sheet}"
end