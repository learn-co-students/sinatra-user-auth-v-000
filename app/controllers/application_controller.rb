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
    # use the data in params to create a new user and log them in by
    # setting the session[:id] equal to the user's id here
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    session[:id] = @user.id

    # this redirect takes us to the route: get '/users/home' that is in the Users Controller
    #   go and look at that route in the Users Controller.
    redirect '/users/home'
  end

  get '/sessions/login' do

    # the line of code below render the view page in app/views/sessions/login.erb
    erb :'sessions/login'
  end

  post '/sessions' do
    # find the user who submitted the log in forms by looking in your database
    #   for the user with the email and password from the params
    # sign them in by setting the session[:id] equal to the user's id

    # redirect the user to this route: get '/users/home'
    #  that route is in the Users Controller. Go check out the code there.
    @user = User.find_by(email: params["email"], password: params["password"])
    session[:id] = @user.id
    redirect '/users/home'
  end

  get '/sessions/logout' do
    # log out the user by clearing the session hash here
    session.clear

    redirect '/'
  end

  get '/users/home' do
    # find the current user by finding the user with the id that is stored
    #   in session[:id]
    # set that user equal to a variable, @user, so that the view found in
    #   app/views/users/home.erb can render that user
    @user = User.find(session[:id])
    erb :'/users/home'
  end



end
