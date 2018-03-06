class ApplicationController < Sinatra::Base
  #==================== CONFIGURATION =====================
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  ------- #Sessions
  configure do
    enable :sessions
    set :session_secret, "secret"
  end
  ---------------------------------------------------------

  
  #==================== HOME ==============================
  get '/' do 
    erb :home
  end
  ---------------------------------------------------------


  #==================== SIGN UP ===========================
  get '/registrations/signup' do
    erb :'/registrations/signup'
  end

  post '/registrations' do
    @user = User.new(params[:signup])
    @user.save
    session[:id] = @user.id
    redirect '/users/home'
  end
  ---------------------------------------------------------


  #==================== LOGIN =============================
  get '/sessions/login' do
    erb :'sessions/login'
  end

  post '/sessions' do
    @user = User.find_by(params[:login])
    session[:id] = @user.id
    redirect '/users/home'
  end
  ---------------------------------------------------------

  
  #==================== LOGOUT ============================
  get '/sessions/logout' do 
    session.clear
    redirect '/'
  end

  get '/users/home' do
   @user = User.find(session[:id])
    erb :'/users/home'
  end
  ---------------------------------------------------------

end
