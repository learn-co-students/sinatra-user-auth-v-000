class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do  # render the home page
    erb :home
  end

  get '/registrations/signup' do  #renders the signup page
    erb :'/registrations/signup'
  end

  post '/registrations' do  #handles the POST request from hitting 'submit' - code comes in from the params hash. we act on this to create a user
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    session[:id] = @user.id
    redirect '/users/home'
  end

  get '/sessions/login' do   # rendering the login form
    erb :'sessions/login'
  end

  post '/sessions' do  # grabs POST request from 'submit' as a params hash.
    @user = User.find_by(email: params["email"], password: params["password"])
    session[:id] = @user.id
    redirect '/users/home'
  end

  get '/sessions/logout' do # logs you out, clears session hash
    session.clear
    redirect '/'
  end

  get '/users/home' do  # renders a users homepage 
    @user = User.find(session[:id])
    erb :'/users/home'
  end

end
