require 'spec_helper'

describe "RegistrationsController" do
  describe "sign up page: GET /registrations/signup" do
    
    before(:each) do
      get '/registrations/signup'
    end

    it "responds with a 200 status code" do
      expect(last_response).to be_ok
    end

    it "renders the signup template" do
      expect(last_response.body).to include("Sign Up")
    end
  end
end
