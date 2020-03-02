class RegistrationsController < ApplicationController

  get '/registrations/signup' do
    erb :'/registrations/signup'
  end

  post '/registrations' do
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    if @user.save
      session[:id]=@user.id
      redirect '/users/home'
    else
      erb :'/registrations/signup'
    end

  end

end
