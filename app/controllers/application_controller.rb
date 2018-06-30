class ApplicationController < Sinatra::Base
    
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

 get '/' do
   erb :'home'
  end

# render the sign-up form view
  get '/registrations/signup' do
      
    erb :'/registrations/signup'
  end

# responsible for handling the POST request w/params
  post '/registrations' do
    @user = User.find_by(email: params[:email])
    session[:id] = @user.id
    
    redirect '/users/home'
  end

#responsible for rendering the login form
  get '/sessions/login' do
      
    erb :'sessions/login'
  end

#responsible for receiving the POST request w/params
  post '/sessions' do
    puts params
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
        session[:id] = @user.id
        
        redirect '/users/home'
       end
        
        redirect '/sessions/login'
  end

#responsible for logging the user out by clearing the session hash
  get '/sessions/logout' do 
    session.clear
    
    redirect '/'
  end

#responsible for rendering the user's homepage view.
  get '/users/home' do
    @user = User.find(session[:id])
    
    erb :'/users/home'
  end

end
