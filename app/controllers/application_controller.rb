require 'pry'
class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  #main home page, contains links to sign up and log in
  get '/' do 
    erb :home
  end

  #directs to signup page
  get '/registrations/signup' do

    erb :'/registrations/signup'
  end

  post '/registrations' do
    #creates new user
    @user = User.new(name: params["name"], email: params["email"], password: params["password"]) 
    #saves to database
    @user.save
    #logs user in
    session[:id] = @user.id
    redirect '/users/home'
  end

  #directs to login page
  get '/sessions/login' do

    erb :'sessions/login'
  end

  #recieves login info
  post '/sessions' do
    @user = User.find_by(email: params["email"], password: params["password"])
    session[:id] = @user.id
    redirect '/users/home'
  end

  #logs out user
  get '/sessions/logout' do 
    session.clear
    redirect '/'
  end

  #sets current user to match session id, directs to home page
  get '/users/home' do
    @user = User.find(session[:id]) #sets current user

    erb :'/users/home' #redirects to user's homepage
  end


end