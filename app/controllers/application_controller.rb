class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :home
  end

  get '/registrations/signup' do #render the signup form view (signup.erb)
    erb :'/registrations/signup'
  end

  post '/registrations' do #handle the POST request from the signup form
    puts params
    redirect '/users/home'
  end

  get '/sessions/login' do #renders the login form (login.erb)
    erb :'sessions/login'
  end

  post '/sessions' do #receives POST request from submit in login.erb
    #grabs user info from params hash, see registration above
    redirect '/users/home'
  end

  get '/sessions/logout' do #logout the user
    #.clear the session hash
    redirect '/'
  end

  get '/users/home' do #render the user's homepage view (home.erb)

    erb :'/users/home'
  end

end
