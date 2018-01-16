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
    # binding.pry

    erb :'/registrations/signup'
  end

  post '/registrations' do
    # puts params
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    # binding.pry
    @user.save
    session[:id] = @user.id
    redirect '/users/home'
    # puts params
  end

  get '/sessions/login' do
    erb :'sessions/login'
  end

  post '/sessions' do
    @user = User.find_by(email: params["email"], password: params["password"])
    session[:id] = @user.id    
    redirect '/users/home'
  end

  get '/sessions/logout' do 
    session.clear
    redirect '/'
  end

  get '/users/home' do    
    erb :'/users/home'
  end
end
