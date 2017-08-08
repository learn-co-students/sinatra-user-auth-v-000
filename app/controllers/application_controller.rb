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
    if params[:name].empty? || params[:email].empty? || params[:password].empty?
      redirect '/registrations/signup'
    else
      user = User.create(name: params[:name], email: params[:email], password: params[:password])
      session[:id] = user.id
      redirect '/users/home'
    end
  end

  get '/sessions/login' do
    erb :'sessions/login'
  end

  post '/sessions' do
    if @user = User.find_by(email: params[:email], password: params[:password])
      session[:id] = @user.id
      redirect '/users/home'
    else
      redirect '/sessions/login'
    end
  end

  get '/sessions/logout' do
    session[:id] = nil
    redirect '/'
  end

  get '/users/home' do
     if @user = User.find(session[:id])
       erb :'/users/home'
     else
       redirect '/'
     end
  end

end
