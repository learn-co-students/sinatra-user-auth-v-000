class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :home #renders site home page view
  end

  get '/registrations/signup' do
    erb :'/registrations/signup' #render the signup form view
  end

  post '/registrations' do #handle the POST request sent when user submits signup form
    #should get the new user's info from params hash
    #create a new user
    #sign the user in
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    session[:id] = @user.id
    redirect '/users/home' #redirect somewhere else, e.g. users home page
  end

  get '/sessions/login' do
    erb :'sessions/login' #renders the login form view
  end

  post '/sessions' do #handles the POST request sent when user submits login form
    #get user's info from params hash
    #match that user info against existing entries in user db
    #if matching entry is found, sign user in
    @user = User.find_by(email: params["email"], password: params["password"])
    session[:id] = @user.id


    redirect '/users/home' #redirect elsewhere
  end

  get '/sessions/logout' do #log user out by clearing session hash
    session.clear

    redirect '/' #redirect to site home page
  end

  get '/users/home' do
    @user = User.find(session[:id])
    erb :'/users/home'  #renders the users homepage view
  end

end
