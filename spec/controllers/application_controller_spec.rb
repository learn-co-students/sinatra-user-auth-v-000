require 'spec_helper'

describe "ApplicationController" do
  describe "homepage: GET /" do

    before(:each) do
      get '/'
    end

    it "responds with a 200 status code" do
      expect(last_response).to be_ok
    end

    it "renders the homepage view, 'home.erb'" do
      expect(last_response.body).to include("Welcome to Hogwarts")
    end
  end

  describe "sign-up page: GET /registrations/signup" do

    before(:each) do
      get '/registrations/signup'
    end

    it "responds with a 200 status code" do
      expect(last_response).to be_ok
    end

    it "renders the sign-up template" do
      expect(last_response.body).to include("Sign Up")
    end
  end

  describe "login page: GET /sessions/login" do

    before(:each) do
      get '/sessions/login'
    end

    it "responds with a 200 status code" do
      expect(last_response).to be_ok
    end

    it "renders the sign-up template" do
      expect(last_response.body).to include("Log In")
    end
  end


end
