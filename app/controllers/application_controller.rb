require 'pry'
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
    # render signup
    erb :'/registrations/signup'
  end

  post '/registrations' do
    # It will have the code that gets the new user's info from the params, creates a new user, signs them in and then redirects them somewhere else
    @user = User.create(params[:user])
    session[:id] = @user.id
    redirect '/users/home'
  end

  get '/sessions/login' do
    # render login form
    erb :'/sessions/login'
  end

  post '/sessions' do
    # grabs the user's info from the params, finds that user from the database and signs that user in
    # binding.pry
    @user = User.find_by(email: params[:user][:email],
                            password: params[:user][:password])
    session[:id] = @user.id
    redirect '/users/home'
  end

  get '/sessions/logout' do
    # This route is responsible for logging the user out by clearing the session hash
    session.clear
    redirect '/'
  end

  get '/users/home' do
    # render a users home view
    # binding.pry
    @user = User.find(session[:id])
    erb :'/users/home'
  end


end
