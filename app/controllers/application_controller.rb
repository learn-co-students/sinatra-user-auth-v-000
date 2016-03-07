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

  get '/registrations/signup' do #render the signup form view

    erb :'/registrations/signup'
  end

  post '/registrations' do #gets new users info from params,creates new user, signs them in and redirects to homepage.
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save 
    session[:id] = @user.id  
    redirect '/users/home'
  end

  get '/sessions/login' do #renders login form and sends it to post sessions

    erb :'sessions/login'
  end

  post '/sessions' do #receives post from login form, grabs user info from params, checks it agains db,and signs user in.
    @user = User.find_by(email: params["email"], password: params["password"])
    session[:id] = @user.id
    redirect '/users/home'
  end

  get '/sessions/logout' do #clears session hash
    session.clear
    redirect '/'
  end

  get '/users/home' do #renders user's homepage views
   @user = User.find(session[:id])
    erb :'/users/home'
  end


end




























