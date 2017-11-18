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

  get '/registrations/signup' do #render the sign-up form view
    erb :'/registrations/signup'
  end

  post '/registrations' do #creates new user, signs them in, and then redirects them to home.
    puts params #our params hash that contains the user's name, email, and password.
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    session[:id] = @user.id
    redirect '/users/home'
  end

  get '/sessions/login' do #responsible for rendering the login form.
    erb :'sessions/login'
  end

  post '/sessions' do #responsible for receiving the POST request that gets sent when a user hits 'submit' on the login form. This route contains code that grabs the user's info from the params hash, looks to match that info against the existing entries in the user database, and, if a matching entry is found, signs the user in.
    @user = User.find_by(email: params["email"], password: params["password"])
    session[:id] = @user.id  #find the correct user from the database and log them in by setting the session[:id] equal to their user ID.
    redirect '/users/home'
  end

  get '/sessions/logout' do #responsible for logging the user out by clearing the session hash.
    session.clear
    redirect '/'
  end

  get '/users/home' do #responsible for rendering the user's homepage view.
    @user = User.find(session[:id])
    erb :'/users/home'
  end

end
