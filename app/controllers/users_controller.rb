class UsersController < ApplicationController

  get '/users/home' do
    @user = User.find(session[:id])
    erb :'/users/home'
  end
  
end
