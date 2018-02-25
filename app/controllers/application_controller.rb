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

  #renders the sign up form
  get '/registrations/signup' do
    erb :'/registrations/signup'
  end

  #gets new user info from the params hash.
  #creates new user, signs them in and redirects elsewhere.
  post '/registrations' do
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    session[:id] = @user.id
    redirect '/users/home'
  end

  #renders login form
  get '/sessions/login' do
    erb :'sessions/login'
  end

  #receives the post request from login form
  #grabs the user info from the params hash.
  #looks to match that info against the existing entries in user db.
  #if matching entry is found, signs the user in.
  post '/sessions' do
    @user = User.find_by(email: params["email"], password: params["password"])
    session[:id] = @user.id
    redirect '/users/home'
  end

  #log user out by clearing session hash
  get '/sessions/logout' do
    session.clear
    redirect '/'
  end

  #renders the user's homepage view.
  get '/users/home' do
    @user = User.find(session[:id])
    erb :'/users/home'
  end

end
