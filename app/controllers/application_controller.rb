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

  # Render the sign-up form view
  get '/registrations/signup' do
    erb :'/registrations/signup'
  end

  # Handles the POST request that is sent when a user hits 'submit' on the sign-up form
  post '/registrations' do
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    session[:id] = @user.id
    redirect '/users/home'
  end

  # Renders the login form
  get '/sessions/login' do
    erb :'sessions/login'
  end

  # Receives the POST request that gets sent when a user hits 'submit' on the login form
  post '/sessions' do
    @user = User.find_by(email: params["email"], password: params["password"])
    session[:id] = @user.id
    redirect '/users/home'
  end

  # Logs out the user by clearing the session hash
  get '/sessions/logout' do 
    session.clear
    redirect '/'
  end

  # Renders the user's homepage view
  get '/users/home' do
    @user = User.find(session[:id])
    erb :'/users/home'
  end

end
