class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  # loged out home page
  get '/' do
    erb :home
  end

  # sign up form
  get '/registrations/signup' do
    erb :'/registrations/signup'
  end

  # sign up backend
  post '/registrations' do
    @user = User.create(params[:user])
    session[:user_id] = @user.id
    redirect '/users/home'
  end

  # sign in form
  get '/sessions/login' do
    erb :'sessions/login'
  end

  # log in backend
  post '/sessions' do
    if @user = User.find_by(email: params[:user][:email])
      if @user.password == params[:user][:password]
        session[:user_id] = @user.id
        redirect '/users/home'
      end
    end
    redirect '/sessions/login'
  end

  # log out backend
  get '/sessions/logout' do 
    session.clear
    redirect '/'
  end

  # user home page
  get '/users/home' do
    @user = User.find(session[:user_id])
    erb :'/users/home'
  end

end
