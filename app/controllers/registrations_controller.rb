class RegistrationsController < ApplicationController

  get '/registrations/signup' do

    erb :'/registrations/signup'
  end

  post '/registrations' do 
    @user = User.new(name: params[:user][:name], email: params[:user][:email], password: params[:user][:password])
    if @user.save
      session[:id] = @user.id
      redirect '/users/home'
    else
      erb :'/registrations/signup'
    end
    
  end

end
