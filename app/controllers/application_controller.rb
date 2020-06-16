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
  
    #this registers new users info after submit button clicked
    post '/registrations' do
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    session[:user_id] = @user.id
    redirect '/users/home'  #will log in & redirect user to home page after signing up 
  end


  #the line of code below render the view page in app/views/sessions/login.erb
  
  get '/sessions/login' do
    
    erb :'sessions/login'
  end

   #user log in form 
  post '/sessions' do 
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id] = @user.id
      redirect '/users/home'
    end
    redirect '/sessions/login'
  end


  #user logout
  get '/sessions/logout' do
    session.clear
    redirect '/'
  end

  get '/users/home' do
    @user = User.find(session[:user_id])
    erb :'/users/home'
  end
end
