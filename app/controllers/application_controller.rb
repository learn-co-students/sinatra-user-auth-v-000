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
    binding.pry
  end

  get '/registrations/signup' do
    erb :'/registrations/signup'

  end

  post '/registrations' do
    @user = User.create(params)
    @session.id = params[:id]
    # @name = params[:name]
    # @email = params[:email]
    # @password = params[:password]
    # @id = params[:id]
binding.pry
    redirect '/users/home'
  end

  get '/sessions/login' do
    erb :'sessions/login'
  end

  post '/sessions' do

    redirect '/users/home'
  end

  get '/sessions/logout' do

    redirect '/'
  end

  get '/users/home' do
    binding.pry
    erb :'/users/home'
  end

end
