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

  get '/registrations/signup' do #renders sign up view
    erb :'/registrations/signup'
  end

  post '/registrations' do #handles POST request sent when user hits submit
    #gets user's new info from params hash
    puts params
    #creates new user
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    #signs them in
    session[:id] = @user.id
    #redirects elsewhere
    redirect '/users/home'
  end

  get '/sessions/login' do #renders login form
    erb :'sessions/login'
  end

  post '/sessions' do #receives POST request that gets sent when a user hits submit on login form
    #grabs user's info from params hash
    #matches that info against existing entries in database
    if @user = User.find_by(email: params["email"], password: params["password"])
    #if matching enrty found, signs user in
      session[:id] = @user.id
      redirect '/users/home'
    else
      redirect 'sessions/login'
    end
  end

  get '/sessions/logout' do #logs user out by clearing out session hash
    session.clear
    redirect '/'
  end

  get '/users/home' do #renders user's homepage view
    #finds current user based on the id value stored in the session hash
    #sets instance variable, user, equal to that found user, allowing us access to that variable in users/home
    @user = User.find(session[:id])
    erb :'/users/home'
  end

end
