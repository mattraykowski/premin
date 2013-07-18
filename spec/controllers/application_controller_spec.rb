require 'spec_helper'
require 'pp'

describe ApplicationController do
  before(:each) { @account = FactoryGirl.create(:account) }

  describe "root domain check" do
    it "should return true for if there is no subdomain" do
      controller.request.host = "foo.com"
      result = controller.is_root_domain?
      result.should be_true
    end

    it "should return true if the subdomain is www" do
      controller.request.host = "www.foo.com"
      result = controller.is_root_domain?
      result.should be_true
    end

    it "should return false if there is a subdomain" do
      controller.request.host = "foobar.foo.com"
      result = controller.is_root_domain?
      result.should be_false
    end
  end

  describe "current account" do

    describe "is root domain" do
      it "should return nil" do
        controller.request.host = "foo.com"
        current_account = controller.current_account
        current_account.should be_nil
      end
    end

    describe "matching subdomain" do
      it "should return the account" do
        controller.request.host = @account.subdomain + ".foo.com"
        current_account = controller.current_account
        current_account.should == @account
      end
    end

    describe "does not match subdomain" do
      pending "should return nil" do
        controller.request.host = @account.subdomain + "a.foo.com"
        controller.current_account
        controller.response.should redirect_to root_url
      end
    end
  end

  describe "account resource check" do
    pending "should redirect you to 'oops' page if the account id does not belong to the current subdomain" do
      controller.request.host = @account.subdomain + ".foo.com"
      controller.is_account_resource?(@account.id + 1)
      controller.response.should redirect_to '/oops'
    end
  end
end
