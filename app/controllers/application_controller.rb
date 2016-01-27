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

  get '/registrations/signup' do #renders the signup page

    erb :'/registrations/signup'
  end

  post '/registrations' do #processes signup
    @user = User.new
    @user.name = params[:name]
    @user.email = params[:email]
    @user.password = params[:password]
    @user.save
    #binding.pry
    session[:id] = @user.id
    redirect '/users/home'
  end

  get '/sessions/login' do #renders login page
    erb :'sessions/login'
  end

  post '/sessions' do #logs in user and remembers user id for the session
    @user = User.find_by(email: params["email"], password: params["password"])
    session[:id] = @user.id
    redirect '/users/home'
  end

  get '/sessions/logout' do #clears session variable
    session.clear
    redirect '/'
  end

  get '/users/home' do #assigns user a session id
   @user = User.find(session[:id])
    erb :'/users/home'
  end


end