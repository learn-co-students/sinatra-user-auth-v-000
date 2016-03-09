class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    if !session[:id].nil?#q
      redirect '/users/home'
    else
      erb :home
    end
  end

  get '/registrations/signup' do
    if !session[:id].nil?
      redirect '/users/home'
    else
      erb :'/registrations/signup'
    end
  end

  post '/registrations' do
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
   @user.save
    session[:id] = @user.id
    redirect '/users/home'
  end

  get '/sessions/login' do
    if !session[:id].nil?
      redirect '/users/home'
    else
      erb :'sessions/login'
    end
  end

  post '/sessions' do
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user.nil?
      @na = true
      erb :'/sessions/login'
    else
      session[:id] = @user.id
      redirect '/users/home'
    end
  end

  get '/sessions/logout' do
    session.clear
    redirect '/'
  end

  get '/users/home' do
    @user = User.find(session[:id])
    erb :'/users/home'
  end


end
