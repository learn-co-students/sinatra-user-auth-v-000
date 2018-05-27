ENV["SINATRA_ENV"] ||= "development"

require 'sinatra/activerecord/rake'
require_relative './config/environment'

task :console do
  require 'irb'
  ARGV.clear
  IRB.start
end

# Type `rake -T` on your command line to see the available rake tasks.