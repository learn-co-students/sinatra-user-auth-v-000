$:.unshift '.'
require 'config/environment'

use Rack::Static, :urls => ['/css'], :root => 'public' # Rack fix allows seeing the css folder.

def check_pending!(connection = Base.connection)
    raise ActiveRecord::PendingMigrationError if connection.migration_context.needs_migration?
end


run ApplicationController
