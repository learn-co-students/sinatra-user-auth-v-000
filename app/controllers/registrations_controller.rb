class RegistrationsController < ApplicationController

  get '/registrations/signup' do

    erb :'/registrations/signup'
  end

  post '/registrations' do 
    # use the data in params to create a new user and log them in by
    # setting the session[:id] equal to the user's id here
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    session[:id] = @user.id

    # this redirect takes us to the route: get '/users/home' that is in the Users Controller
    #   go and look at that route in the Users Controller. 
    redirect '/users/home'
  end

end
