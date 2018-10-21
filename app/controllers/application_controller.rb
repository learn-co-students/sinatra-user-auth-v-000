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
    #binding.pry
    erb :'/registrations/signup'
  end

  post '/registrations' do
    #binding.pry
#<<<<<<< HEAD
    #puts params
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    #@user = User.find_by(email: params[:email])
    session[:id] = @user.id
    redirect '/users/home'
#=======
    #@user = User.find_by(email: params[:email])
    #session[:user_id] = @user.id
#>>>>>>> 5854311f8f1f72b4786957a15d75331974009389
  end

  get '/sessions/login' do
    erb :'sessions/login'
  end

  post '/sessions' do
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id] = @user.id
      redirect '/users/home'
    end

    redirect '/sessions/login'
  end

  get '/sessions/logout' do

    redirect '/'
  end

  get '/users/home' do
    @user = User.find(session[:id])
    erb :'/users/home'
  end

end
