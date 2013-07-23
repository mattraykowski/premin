require 'spec_helper'

describe User do
  before(:each) { @user = FactoryGirl.create(:user) }

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:name) }
  it { should respond_to(:account_id) }
  it { should respond_to(:account) }

  # Role-related
  it { should respond_to(:is_site_admin) }

  describe "when email is not present" do
    before { @user.email = " " }

    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@example,com user_at_example.com user@example. user@example_site.com user@example+site.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM USER_A@a.b.org user.person@example.com user+name@example.co]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end

  #####################
  #                   #
  # Testing Callbacks #
  #                   #
  #####################
  describe "when created" do
    describe "when account exists" do
      before(:each) do
        @existing_account = FactoryGirl.create(:account)
      end

      it "should not create a new account" do
        expect{FactoryGirl.create(:user2, account_subdomain: @existing_account.subdomain, account_name: @existing_account.subdomain)}.not_to change{Account.count}
      end
    end

    describe "when account does not exist" do
      it "should create a new account" do
        expect{FactoryGirl.create(:user2, account_subdomain: "somerandomname", account_name: "randomname")}.to change{Account.count}
      end
    end

    describe "after creation" do
      describe "when account does not have an owner" do
        it "should assign the new account itself as the owner" do
          @user.account.owner.should == @user
        end

        it "should become the site admin" do
          @user.is_site_admin.should be_true
        end
      end
    end
  end
end
