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

  # render signup form view
  get '/registrations/signup' do
    erb :'/registrations/signup'
  end

  # handle the post request from the signup form, including adding id to session
  post '/registrations' do
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    session[:id] = @user.id
    redirect '/users/home'
  end

  # render the login form
  get '/sessions/login' do
    erb :'sessions/login'
  end

  # handling the post reuqest from login form, look for info in db, set the session id if correct
  post '/sessions' do
    @user = User.find_by(email: params["email"], password: params["password"])
    session[:id] = @user.id
    redirect '/users/home'
  end

  # log user out by clearing session hash.
  get '/sessions/logout' do
    session[:id] = nil
    redirect '/'
  end

  # render homepage view.
  get '/users/home' do
    @user = User.find(session[:id])
    erb :'/users/home'
  end

end
