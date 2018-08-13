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

  get '/registrations/signup' do #renders the sign-up form view
    erb :'/registrations/signup'
  end

  post '/registrations' do #handles the post request when user submits the sign-up form
    #get the new user's info from the params hash
    #create a new user
    #sign in the user
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    session[:id] = @user.id
    redirect '/users/home'
  end

  get '/sessions/login' do #renders the login form
    erb :'sessions/login'
  end

  post '/sessions' do #receives the post request when user submitted the login form
    #grab the user's info from the params hash
    #look to match the info against the existing entries in the user database
    #if a match is found, the user is signed in
    @user = User.find_by(email: params["email"], password: params["password"])
    if @user
      session[:id] = @user.id
      redirect '/users/home'
    else
      redirect "/sessions/login"
    end
  end

  get '/sessions/logout' do #logs the user out by clearing the session hash
    session.clear
    redirect '/'
  end

  get '/users/home' do #renders the user's homepage view
    #finds the current user based on the ID value stored in the session hash
    #sets an instance variable, @user, equal to that found user, allowing us
    #to access the current user in the corresponding view page
    @user = User.find(session[:id])
    erb :'/users/home'
  end

end
