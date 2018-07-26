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
    User.create(name: params[:name], email: params[:email], password: params[:password])
# binding.pry
    erb :'/registrations/signup'
  end

  post '/registrations' do
    @user = User.create(name: params[:name], email: params[:email], password: params[:password])
    # @user.id = params[:id]
    binding.pry

    redirect '/users/home'
  end

  get '/sessions/login' do
    erb :'sessions/login'
  end

  post '/sessions' do
    User.find_by(email: params[:email], password: params[:password])
    session[:id]

    redirect '/users/home'
  end

  get '/sessions/logout' do

    redirect '/'
  end

  get '/users/home' do

    erb :'/users/home'
  end

end
