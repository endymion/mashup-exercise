require 'simplecov'
SimpleCov.start

require_relative '../app'

require 'sinatra'
require 'rack/test'

require 'debugger'
require 'fakeweb'

# setup test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

def app
  Sinatra::Application
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
end