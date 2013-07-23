require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    it "returns http success" do
      get :index
      response.should be_success
    end
  end

  describe "GET 'about'" do
    it "returns http success" do
      get :about
      response.should be_success
    end
  end

  describe "GET 'contact'" do
    it "returns http success" do
      get :contact
      response.should be_success
    end
  end

  describe "GET 'oops'" do
    it "returns http success" do
      get :oops
      response.should be_success
    end
  end

  describe "GET 'customers'" do
    # Create a user, which creates an owned account.
    before { @user = FactoryGirl.create(:user) }
    it "assigns all accounts as @accounts" do
      get :customers, {}
      assigns(:accounts).should eq(Account.all)
    end
  end

  describe "GET 'news'" do
    pending "assigns and paginates news."
  end

end
