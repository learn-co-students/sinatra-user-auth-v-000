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
    #binding.pry 
    @user = User.find_or_create_by(:name => params[:name], :email => params[:email], :password => params[:password])
    @user.save

    session[:id] = @user.id

    redirect '/users/home'
  end

  get '/sessions/login' do
    erb :'sessions/login'
  end

  post '/sessions' do
    @user = User.find_or_create_by(email: params[:email], password: params[:password])
    @user.id = session[:id]
    redirect '/users/home'
  end

  get '/sessions/logout' do
    session.clear
    redirect '/'
  end

  get '/users/home' do
    @user = User.find_by(session[:id])
    erb :'/users/home'
  end

end