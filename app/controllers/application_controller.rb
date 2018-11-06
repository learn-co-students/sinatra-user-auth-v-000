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

  get '/registrations/signup' do #has one responsibility: render the sign-up form view.
    erb :'/registrations/signup'
  end

  post '/registrations' do #responsible for handling the POST request that is sent when a user hits 'submit' on the sign-up form.
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save

    @user = User.find_by(email: params[:email])
    session[:user_id] = @user.id

    redirect '/users/home'
  end

  get '/sessions/login' do #responsible for rendering the login form.
    erb :'sessions/login'
  end

  post '/sessions' do #responsible for receiving the POST request that gets sent when a user hits 'submit' on the login form.
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id] = @user.id
      redirect '/users/home'
    end
    redirect '/session/login'
  end

  get '/users/home' do #route is responsible for rendering the user's homepage view.
        @user = User.find(session[:user_id])
    erb :'/users/home'
  end

end
