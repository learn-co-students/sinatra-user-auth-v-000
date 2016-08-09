class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do 
    @session = session
    erb :home
  end

  get '/registrations/signup' do
    erb :'/registrations/signup'
  end

  post '/registrations' do 
    @user = User.create(name: params[:name], email: params[:email], password: params[:password])
    session[:id] = @user.id
    redirect '/users/home'
  end

  get '/sessions/login' do
    erb :'sessions/login'
  end

  post '/sessions' do
    #add user.id to @session[:id]
    redirect '/users/home'
  end

  get '/sessions/logout' do 
    #clears sessions hash
    redirect '/'
  end

  get '/users/home' do
    # find user by id and store in @user 
    erb :'/users/home'
  end


end