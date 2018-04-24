ENV["SINATRA_ENV"] ||= "development"

require 'sinatra/activerecord/rake'
require_relative './config/environment'

namespace :db do
  task :load_config do
    require "./app/controllers/application_controller"
  end
end

# Type `rake -T` on your command line to see the available rake tasks.
