require 'spec_helper'

describe "User sign up, log in, sign out" do

  let!(:valid_user) {User.create(name: "Beini Huang", email: "beini@bee.com", password: "password")}

  describe "user sign up" do

    before(:each) do
      visit '/'
      click_link('Sign Up')
    end

  
end
