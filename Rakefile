ENV["SINATRA_ENV"] ||= "development"

require 'sinatra/activerecord/rake'
require_relative './config/environment'

desc "gimme a console!"
task :console do
  Pry.start
end