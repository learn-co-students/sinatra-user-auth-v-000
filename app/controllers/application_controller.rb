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
    User.new(
      name: params["name"],
      email: params["email"],
      password: params["password"]
      ).tap do |user|
        user.save
        session[:id] = user.id
      end

    redirect '/users/home'
  end

  get '/sessions/login' do
    erb :'sessions/login'
  end

  post '/sessions' do
    session[:id] = User.find_by(params).id
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
