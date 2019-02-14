require 'pry'

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
    @user.save #AVI put this here already to troll you on valentines day
    session[:user_id] = @user.id
    puts params #added because of readme
    #We did it! We registered a new user! Now we just need to sign them in.
    #On the following line, set the session[:id] equal to our new user's ID:
    redirect '/users/home'
  end

  get '/sessions/login' do

    # the line of code below render the view page in app/views/sessions/login.erb
    erb :'sessions/login'
  end

  post '/sessions' do
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id] = @user.id
      redirect '/users/home'
    end
    redirect '/sessions/login'
  end

  get '/sessions/logout' do
    session.clear
    redirect '/'
  end

  get '/users/home' do
    @user = User.find(session[:user_id]) #:user_id
    erb :'/users/home'
  end
end
