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
    puts params
    @user = User.new(name: params["name"], email: params["email"], password: params[:password])
    @user.save
    session[:id] = @user.id

    #user info into params hash, create new user, sign them in, redicret
    redirect '/users/home'
  end

#render login form
  get '/sessions/login' do
    erb :'sessions/login'
  end

  post '/sessions' do
    #receive Post request, code to grab users info from params hash, match that info against the etnries in db, and if ===, sign in user
    @user = User.find_by(email: params["email"], password: params[:password])
    session[:id] = @user.id
    redirect '/users/home'
  end

  get '/sessions/logout' do
    #clear the session 
    session.clear
    redirect '/'
  end

  get '/users/home' do
   #render user's homepage view
   @user = User.find(session[:id])
    erb :'/users/home'
  end

end
