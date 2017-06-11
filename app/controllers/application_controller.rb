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

#render the sign-up form view.
  get '/registrations/signup' do
    erb :'/registrations/signup'
  end

#handling the POST request that is sent when a user hits 'submit' on the sign-up form.
  post '/registrations' do
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    session[:id] = @user.id
    redirect '/users/home'
  end

#rendering the login form.
  get '/sessions/login' do
    erb :'sessions/login'
  end

#receiving the POST request that gets sent when a user hits 'submit' on the login form.
  post '/sessions' do
    @user = User.find_by(email: params["email"], password: params["password"])
    session[:id] = @user.id
    redirect '/users/home'
  end

#logging the user out by clearing the session hash.
  get '/sessions/logout' do
    session.clear
    redirect '/'
  end

#rendering the user's homepage view.
  get '/users/home' do
    @user = User.find(session[:id])
    erb :'/users/home'
  end

end
