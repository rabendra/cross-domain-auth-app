require 'spec_helper'

RSpec.describe Api::RegistrationsController, type: :controller do


  before(:each) do
    @user_attr = FactoryGirl.attributes_for :person
    @request.env["devise.mapping"] = Devise.mappings[:person]
  end

  describe "Sign up with valid data" do

    it "new user with Valid data" do
    
      post :create ,people: @user_attr.slice(:community_id, :password, :username, :email)  
      expect(response.status).to eq(200)

    end

    it "get authentication token" do
      post :create ,people: @user_attr.slice(:community_id, :password, :username, :email) 
      expect(JSON.parse(response.body)["user_token"]).to be_truthy
    end    
  end  

  it "Sign up with Invalid data" do
    @user_attr[:email] = @user_attr[:email].gsub('@example.com', '')
    post :create ,people: @user_attr.slice(:community_id, :password, :email) 
      expect(response.status).to eq(400)
  end
end