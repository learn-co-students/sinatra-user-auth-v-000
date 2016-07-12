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
    # uses the data in params to create a new user and logs them in by
    # setting the session[:id] equal to the user's id 
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    session[:id] = @user.id

    # redirects to the route: get '/users/home' which is in the Users Controller
    redirect '/users/home'
  end

  get '/sessions/login' do
    # renders the view page in app/views/sessions/login.erb
    erb :'sessions/login'
  end

  post '/sessions' do
    # finds the user who submitted the log in form by looking in your database 
    #   for the user with the email and password from the params,
    # signs them in by setting the session[:id] equal to the user's id
  
    @user = User.find_by(email: params["email"], password: params["password"])
    session[:id] = @user.id

    # redirects the user to this route: get '/users/home'
    redirect '/users/home'
  end

  get '/sessions/logout' do 
    # logs out the user by clearing the session hash here
    session.clear
    redirect '/'
  end

  get '/users/home' do
    # finds the current user by finding the user with the id that is stored in session[:id]
    # sets user equal to @user, so that app/views/users/home.erb view file can render that user
    @user = User.find(session[:id])
    erb :'/users/home'
  end
end