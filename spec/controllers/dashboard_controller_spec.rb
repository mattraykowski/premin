require 'spec_helper'

describe DashboardController do
  describe "GET 'index'" do
    include_context "create valid page"
    before(:each) do
      @page.update_attributes(sidebar: true)
      @page2 = FactoryGirl.create(:page, account: @user.account, title: @page.title+"1")
    end

    it "should return a list of @pages" do
      get :index, {}
      assigns(:pages).should eq([@page])
    end
  end

end
