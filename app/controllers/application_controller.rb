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

  get '/registrations/signup' do
    #render the sign-up form view
    erb :'/registrations/signup'
  end

  post '/registrations' do
    #handles the POST request that's sent when 'submit' is hit on registration form
    # get & create new user info from params hash
    # log new user in
    # redirect them somewhere else
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    session[:id] = @user.id
    redirect '/users/home'
  end

  get '/sessions/login' do
    #render login form
    erb :'sessions/login'
  end

  post '/sessions' do
    # receive POST request that's sent when user hits 'submit' on login form
    # grabs user info from params hash and signs user in if a matching entry is found in the user db
    @user = User.find_by(email: params["email"], password: params["password"])
    session[:id] = @user.id
    redirect '/users/home'
  end

  get '/sessions/logout' do
    # clear session hash
    session.clear
    redirect '/'
  end

  get '/users/home' do
    # render the user's homepage view
    @user = User.find(session[:id])
    erb :'/users/home'
  end

end
