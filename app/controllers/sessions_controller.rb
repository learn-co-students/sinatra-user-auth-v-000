class SessionsController < ApplicationController
  

  get '/sessions/login' do

    # the line of code below render the view page in app/views/sessions/login.erb
    erb :'sessions/login'
  end

  post '/sessions' do
    # find the user who submitted the log in forms by looking in your database 
    #   for the user with the email and password from the params
    # sign them in by setting the session[:id] equal to the user's id

    # redirect the user to this route: get '/users/home' 
    #  that route is in the Users Controller. Go check out the code there. 
    @user = User.find_by(email: params["email"], password: params["password"])
    session[:id] = @user.id
    redirect '/users/home'
  end

  get '/sessions/logout' do 
    # log out the user by clearing the session hash here
    session.clear
    redirect '/'
  end
end