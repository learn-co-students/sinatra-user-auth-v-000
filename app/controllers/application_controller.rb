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
<<<<<<< HEAD
    # use the data in params to create a new user and log them in by
    # setting the session[:id] equal to the user's id here
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    session[:id] = @user.id

    # this redirect takes us to the route: get '/users/home' that is in the Users Controller
    #   go and look at that route in the Users Controller.
=======
    @user = User.find_by(email: params[:email])
    session[:user_id] = @user.id
>>>>>>> solution updated and working
    redirect '/users/home'
  end

  get '/sessions/login' do

    # the line of code below render the view page in app/views/sessions/login.erb
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

    @user = User.find(session[:user_id])
    erb :'/users/home'
  end



end
