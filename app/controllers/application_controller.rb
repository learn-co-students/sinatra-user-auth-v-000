class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

#renders homepage (welcome)
  get '/' do
    erb :home
  end

#simply renders sign-up form view
  get '/registrations/signup' do
    erb :'/registrations/signup'
  end

#handles POST request that is sent when user hits "submit" on sign-up form
  post '/registrations' do
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    session[:id] = @user.id

    redirect '/users/home'
  end

#simply renders login form
  get '/sessions/login' do
    erb :'sessions/login'
  end

#receives POST request that gets sent when user hits "submit" on login form
  post '/sessions' do
    @user = User.find_by(email: params["email"], password: params["password"])
    if @user
      session[:id] = @user.id
      redirect '/users/home'
    end
    redirect '/sessions/login'
  end

#logs user out by clearing the session hash
  get '/sessions/logout' do
    session.clear

    redirect '/'
  end

#renders user's homepage view
  get '/users/home' do
    @user = User.find(session[:id])

    erb :'/users/home'
  end

end
