require 'spec_helper'

describe "SessionsController" do
  describe "log-in page: GET /sessions/login" do
    
    before(:each) do
      get '/sessions/login'
    end

    it "responds with a 200 status code" do
      expect(last_response).to be_ok
    end

    it "renders the signup template" do
      expect(last_response.body).to include("log in below:")
    end
  end
end
