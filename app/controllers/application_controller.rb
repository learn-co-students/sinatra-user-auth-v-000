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
    #Creates a new User with data
    @user = User.new(name: params[:name], email: params[:email], password: params[:password])
    #saves User to database
    @user.save
    #Signs in to the session
    session[:id] = @user.id
    #Redirects to the home page
    redirect '/users/home'
  end

  get '/sessions/login' do
    erb :'sessions/login'
  end

  post '/sessions' do
    #Finds login data
    #Matches login data to user
    @user = User.find_by(email: params["email"], password: params["password"])
    if @user
      #Signs in the user
      session[:id] = @user.id

      redirect '/users/home'
    else
      redirect '/sessions/login'
    end
  end

  get '/sessions/logout' do
    #Clear the session hash
    session.clear

    redirect '/'
  end

  get '/users/home' do
    #Find current user based on the session id
    #Set current user instance to current session id
    @user = User.find(session[:id])

    erb :'/users/home'
  end

end
