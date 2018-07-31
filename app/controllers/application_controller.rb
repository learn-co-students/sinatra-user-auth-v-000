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
		@user = User.new
		@user.name = params[:user][:name]
		@user.email = params[:user][:email]
		@user.password = params[:user][:password]
		@user.save

		session[:id] = @user.id
    redirect '/users/home'
  end

  get '/sessions/login' do
    erb :'sessions/login'
  end

  post '/sessions' do
		@user = User.find_by(email: params[:user][:email], password: params[:user][:password])
		
		redirect 'sessions/login' if !@user		
		
		session[:id] = @user.id
		redirect '/users/home'
  end

  get '/sessions/logout' do 

    redirect '/'
  end

  get '/users/home' do
		@user = User.find(session[:id])
    erb :'/users/home'
  end

end
