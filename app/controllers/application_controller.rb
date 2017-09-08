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
    session[:id] = User.create(params)
    redirect '/users/home'
  end

  get '/sessions/login' do
    erb :'sessions/login'
  end

  post '/sessions' do
		session[:id] = User.find_by(email: params[:email], password: params[:password]).id
    redirect '/users/home'
  end

  get '/sessions/logout' do
		session.clear
    redirect '/'
  end

  get '/users/home' do
		return "No Session" if session[:id]==nil
		@user = User.find(session[:id])
    erb :'/users/home'
  end

end
