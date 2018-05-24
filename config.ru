$:.unshift "."
require "config/environment"

use Rack::Static, :urls => ["/css"], :root => "public" # Rack fix allows seeing the css folder.

run ApplicationController
