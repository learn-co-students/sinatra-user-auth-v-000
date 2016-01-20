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

  get '/users/home' do  
    if session[:id]==nil
      redirect to '/' 
    else
      @user = User.find(session[:id]) 
      erb :'/users/home'
    end
  end

  post '/registrations' do 
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save #if @user.valid?
    puts params
    session[:id]=@user.id
    redirect '/users/home'
  end

  get '/sessions/login' do

    erb :'sessions/login'
  end

  get '/sessions/logout' do
    session.clear
    redirect to '/'
  end

  post '/sessions' do
    @user=User.find_by(email: params[:email], password: params[:password])
    #binding.pry
    session[:id]=@user.id
    redirect '/users/home'
  end

  get '/sessions/logout' do 

    redirect '/'
  end



end