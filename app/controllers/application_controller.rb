class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

# renders the homepage view
  get '/' do
    erb :home
  end

# renders the sign-up template
  get '/registrations/signup' do
    erb :'/registrations/signup'
  end

# uses the data in params to create a new user
# logs them in by setting the session[:id] equal to the user's id
  post '/registrations' do
    @user = User.find_by(email: params[:email])
    session[:user_id] = @user.id
    redirect '/users/home'
  end

# renders the login template
  get '/sessions/login' do
    erb :'sessions/login'
  end

# finds user from log in form by matching the email and password from the params to the database
# signs them in by setting the session[:id] equal to the user's id
# redirects the user to user's homepage: get '/users/home'
# that route is in the Users Controller. Go check out the code there.
  post '/sessions' do
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id] = @user.id
      redirect '/users/home'
    end
    redirect '/sessions/login'
  end

# logs out the user by clearing the session hash
# redirects to the homepage
  get '/sessions/logout' do
    session.clear
    redirect '/'
  end

# find the current user by finding the user with the id stored in session[:id]
# sets that user equal @user variable so the user homepage view can use that info to welcome the user
  get '/users/home' do
    @user = User.find(session[:user_id])
    erb :'/users/home'
  end

end
