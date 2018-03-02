#====================================================== 
class ApplicationController < Sinatra::Base
#========================config======================== 
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }
#--------------------------------------------sessions-# 
  configure do
    enable :sessions
    set :session_secret, "secret"
  end
#========================routes======================== 
  # HOME
#------------------------------------------------home-# 
  get '/' do 
    erb :home
  end
#====================================================== 
  # SIGN UP
#---------------------------------registration/signup-# 
  get '/registrations/signup' do 
    erb :'/registrations/signup'
  end

  post '/registrations' do 
    @user = User.create(params) 
    session[:id] = @user.id
  
    redirect '/users/home'
  end
#====================================================== 
  # LOG IN 
#--------------------------------------sessions/login-# 
  get '/sessions/login' do
    erb :'sessions/login'
  end

  post '/sessions' do
    @user = User.find_by(params)
    session[:id] = @user.id
    
    redirect '/users/home'
  end
#====================================================== 
  # LOG OUT 
#---------------------------------------------------/-# 
  get '/sessions/logout' do 
    session.clear
    redirect '/'
  end
#====================================================== 
  # USER HOME
#------------------------------------------users/home-# 
  get '/users/home' do 
    @user = current_user
    erb :'/users/home'
  end
#====================================================== 
  # HELPERS
#----------------------------------------current user-# 
  def current_user
    User.find(session[:id])
  end
#====================================================== 
end
