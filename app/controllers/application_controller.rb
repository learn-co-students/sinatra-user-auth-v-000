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
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    # puts params
    session[:id] = @user.id
    redirect '/users/home'
  end

  get '/sessions/login' do
    # binding.pry
    erb :'sessions/login'
  end

  post '/sessions' do
    # binding.pry
    @user = User.find_by(email: params["email"], password: params["password"])
    # binding.pry
    if @user
      session[:id] = @user.id
      redirect '/users/home'
    else
      redirect '/sessions/login'

    end
  end

  get '/sessions/logout' do
    session.clear
    redirect '/'
  end



  get '/users/home' do
    # binding.pry

  @user = User.find(session[:id])
  # @user = User.find_by_id(session[:id])
  # binding.pry
  erb :'/users/home'
  # redirect to post '/'
end

  post '/' do
    redirect '/'
  end

end
