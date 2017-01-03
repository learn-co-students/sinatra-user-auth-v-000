class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  #Homepage
  get '/' do
    erb :home
  end

  #Render sign-up form view
  get '/registrations/signup' do
    erb :'/registrations/signup'
  end

  #Handling POST request from User sign-up form; create User instance and redirect to the user page
  post '/registrations' do
    #puts params
    @user = User.create(name: params[:name], email: params[:email], password: params[:password])
    #@user.save
    session[:id] = @user.id
    redirect '/users/home'
  end

  #Render the log-in form view
  get '/sessions/login' do
    erb :'sessions/login'
  end

  #Handling POST request from User log-in form; set the session id if a matching user is found, and sign them in
  post '/sessions' do
    puts params
    @user = User.find_by(email: params[:email], password: params[:password])
    session[:id] = @user.id
    redirect '/users/home'
  end

  #Log out the user by clearing the session hash
  get '/sessions/logout' do
    session.clear
    redirect '/'
  end

  #Renders the User Homepage view
  get '/users/home' do
    @user = User.find(session[:id])
    #binding.pry
    erb :'/users/home'
  end

end
