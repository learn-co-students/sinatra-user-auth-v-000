class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    #render the home page view
    erb :home
  end

  get '/registrations/signup' do
    #renders sign-up view
    erb :'/registrations/signup'
  end

  post '/registrations' do
    #should handle 'POST' request from sign-up form
    #and contain code that takes info from params
    #creates a new user
    #signs in the new user
    #then redirects them to a new location
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    session[:id] = @user.id
    redirect '/users/home'
  end

  get '/sessions/login' do
    #renders login form
    erb :'sessions/login'
  end

  post '/sessions' do
    #receives post request from log-in form
    #grabs user's info from params
    #matchs info against exsiting entries in user database
    #if matching entry is found, user is signed in
    @user = User.find_by(email: params["email"], password: params["password"])
    if @user
      session[:id] = @user.id
      redirect '/users/home'
    else
      redirect '/sessions/login'
    end
  end

  get '/sessions/logout' do
    #should log the user out by clearing the 'session' hash
    session.clear
    redirect '/'
  end

  get '/users/home' do
    #render homepage view
    @user = User.find(session[:id])
    erb :'/users/home'
  end

end
