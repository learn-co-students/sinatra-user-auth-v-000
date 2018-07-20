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
    # render the signup form view

    erb :'/registrations/signup'
  end

  post '/registrations' do
    # get the new user's info from the params hash
    # create a new user
    # signs them in
    # redirects them elsewhere
    @user = User.new(name: params[:users][:name], email: params[:users][:email], password: params[:users][:password])
    @user.save
    session[:id] = @user.id

    redirect '/users/home'
  end

  get '/sessions/login' do
    # render the login form

    erb :'sessions/login'
  end

  post '/sessions' do
    # when user hits submit login form
    # grams user's info from the params hash
    # looks for that user in the database
    # if a match is found, sign the user in
    @user = User.find_by(email: params[:users][:email], password: params[:users][:password])

    if @user
      session[:id] = @user.id
      redirect '/users/home'
    else
      redirect 'sessions/login'
    end
    
  end

  get '/sessions/logout' do 
    # log the user out by clearing the session hash
    session.clear

    redirect '/'
  end

  get '/users/home' do
    # render the user's homepage view
    @user = User.find(session[:id])

    erb :'/users/home'
  end

end
