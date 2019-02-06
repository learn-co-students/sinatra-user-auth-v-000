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

  get '/registrations/signup' do # render the sign-up form view

    erb :'/registrations/signup' #     rendering the sign-up template.

  end

  post '/registrations' do # handling the POST request that is sent when a user hits 'submit' on the sign-up form
    puts params
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    session[:user_id] = @user.id

    redirect '/users/home'
  end

  get '/sessions/login' do # rendering the login form.

    # the line of code below render the view page in app/views/sessions/login.erb
    erb :'sessions/login'
  end

  post '/sessions' do #receiving the POST request that gets sent when a user hits 'submit' on the login form.
    puts params
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id] = @user.id
      redirect '/users/home'
    end
    redirect '/sessions/login'
  end

  get '/sessions/logout' do #logging the user out by clearing the session hash.
    session.clear
    redirect '/'
  end

  get '/users/home' do #rendering the user's homepage view.

    @user = User.find(session[:user_id])
    erb :'/users/home'
  end
end
