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
    erb :'/registrations/signup'
  end

  post '/registrations' do
    #create new user using form input
    #save user
    #set session[:id]
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    session[:id] = @user.id
    redirect '/users/home'
  end

  get '/sessions/login' do
    erb :'sessions/login'
  end

  post '/sessions' do
    #first find user
    #set session[:id] to @user.id
    @user = User.find_by(email: params["email"], password: params["password"])
    session[:id] = @user.id

    redirect '/users/home'
  end

  get '/sessions/logout' do
    session.clear  #clear session
    redirect '/'
  end

  get '/users/home' do
    # find user by session[:id] == @user.id
    @user = User.find(session[:id])
    erb :'/users/home'
  end

end
