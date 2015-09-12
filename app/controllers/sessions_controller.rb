class SessionsController < ApplicationController
  

  get '/sessions/login' do
    erb :'sessions/login'
  end

  post '/sessions' do
    @user = User.find_by(email: params["user"]["email"], password: params["user"]["password"])
    session[:id] = @user.id

    redirect '/users/home'
  end

  get '/sessions/logout' do 
    session.clear

    redirect '/'
  end
end