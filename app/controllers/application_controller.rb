class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

# :notes the user id are created automaticly.
  get '/' do
    erb :home
  end

  get '/registrations/signup' do  # render sign up page
    erb :'/registrations/signup'
  end

  post '/registrations' do
    #User infor in posted here after "submit button"
    # we are creating a new account which get an ID automatic because of our data base
    @user = User.new(name: params["name"],
            email: params["email"],
            password: params["password"])
        #then it saved and giving an ID.
            @user.save
            session[:id] = @user.id
    redirect '/users/home'
  end

  get '/sessions/login' do  #render the log in form
    erb :'sessions/login'
  end

  post '/sessions/login' do
    #handles logged in input of user from the params / Match that infor
    # with existing entries in the user database.
  @user = User.find_by(email: params["email"], password: params["password"])
  session[:id] = @user.id
   #if  entrie matches, user is logged in
    redirect '/users/home'
  end

  get '/sessions/logout' do
    # log user out by clearing the session
      session.clear
    redirect '/'
  end

  get '/users/home' do
    #Render the users home page based on id.
    @user = User.find(session[:id])

    erb :'/users/home'
  end

end
