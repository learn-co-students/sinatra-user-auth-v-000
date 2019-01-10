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

  #signup form
  get '/registrations/signup' do
    erb :'/registrations/signup'
  end

  #create new user, sign in user, and redirect user to their homepage
  post '/registrations' do
    puts params
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    session[:id] = @user.id
    redirect '/users/home'
  end

  #login form
  get '/sessions/login' do
    erb :'sessions/login'
  end

  #get user info to match info against entries in user database. If entry found, sign user in
  post '/sessions' do
    puts params
    @user = User.find_by(email: params["email"], password: params["password"])
    if @user
      session[:id] = @user.id
      redirect '/users/home'
    end
    #if password is incorrect, redirect to login page
    redirect '/sessions/login'
  end

  #log out user
  get '/sessions/logout' do
    session.clear
    redirect '/'
  end

  #homepage view
  get '/users/home' do
    @user = User.find(session[:id])
    erb :'/users/home'
  end

end
