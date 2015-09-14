class RegistrationsController < ApplicationController

  get '/registrations/signup' do

    erb :'/registrations/signup'
  end

  post '/registrations' do 
    # use the data in params to create a new user and log them in by
    # setting the session[:id] equal to the user's id here
    
    redirect '/users/home'
  end

end
