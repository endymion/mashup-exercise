require 'rspec/core/rake_task'

task :default => [:run]

desc "run sinatra app locally"
task :run => "Gemfile.lock" do
  require_relative 'app'
  Sinatra::Application.run!
end

desc "run specs"
RSpec::Core::RakeTask.new(:spec)