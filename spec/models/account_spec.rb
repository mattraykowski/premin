require 'spec_helper'

describe Account do
  before(:each) { @account = FactoryGirl.create(:account) }

  subject { @account }

  #it { should respond_to(:name) }
  it { should respond_to(:users) }
  it { should respond_to(:owner) }
  it { should respond_to(:subdomain) }
  it { should respond_to(:name) }

  describe "when subdomain is not present" do
    before { @account.subdomain = " " }
    it { should_not be_valid }
  end

  describe "when subdomain is already taken" do
    before do
      @account_with_same_name = @account.dup
    end
    subject { @account_with_same_name }
    it { should_not be_valid }
  end

  describe "when subdomain format is invalid" do
    it "should be invalid" do
      names = %w[01010 A0c- -A0c]
      names.each do |invalid_name|
        @account.subdomain = invalid_name
        @account.should_not be_valid
      end
    end
  end

  describe "when subdomain name format is valid" do
    it "should be valid" do
      names = %w[abc A0c A-0c a 0--0]
      names.each do |valid_name|
        @account.subdomain = valid_name
        @account.should be_valid
      end 
    end
  end

  describe "when name is not present" do
    before { @account.name = " " }
    it { should_not be_valid }
  end

    
end
