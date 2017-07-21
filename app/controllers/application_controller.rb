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
    #add the line puts params inside the post '/registrations' route in the controller.
    @user = User.new(name: params[:name], email: params[:email], password: params[:password])
    @user.save
    session[:id] = @user.id
    redirect '/users/home'
  end

  get '/sessions/login' do
    erb :'sessions/login'
  end

  post '/sessions' do
    #place the line puts params in the post '/sessions' route.
    #Inside the post '/sessions' route, let's write the lines of code that will
    #find the correct user from the database and log them in by setting the session[:id] equal to their user ID.
    @user = User.find_by(email: params[:email], password: params[:password])
    session[:id] = @user.id
    redirect '/users/home'
  end

  get '/sessions/logout' do
    #In the get '/sessions/logout' route in the controller, put: session.clear
    session.clear
    redirect '/'
  end

  get '/users/home' do
    #First, this route finds the current user based on the ID value stored in the session hash.
    #Then, it sets an instance variable, @user, equal to that found user, allowing us to access the current user in the corresponding view page.
    @user = User.find(session[:id])
    erb :'/users/home'
  end

end
