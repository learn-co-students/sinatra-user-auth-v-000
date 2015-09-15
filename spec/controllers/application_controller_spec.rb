require 'spec_helper'

describe "ApplicationController" do
  describe "home page: GET /" do
    
    before(:each) do 
      get '/'
    end

    it "responds with a 200 status code" do
      expect(last_response).to be_ok
    end

    it "renders the home page view, 'home.erb'" do
      expect(last_response.body).to include("Welcome to Hogwarts")
    end
  end

end
