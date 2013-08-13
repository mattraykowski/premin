require 'spec_helper'

describe MailingList do
  before { @mailing_list = FactoryGirl.create(:mailing_list) }
  subject { @mailing_list }

  it { should respond_to :email }
  it { should respond_to :subscribed }

  describe "when email is not present" do
    before { @mailing_list.email = " " }
    it { should_not be_valid }
  end

  describe "when email is already submitted" do
    before { @duplicate_mailing_list = @mailing_list.dup }
    subject { @duplicate_mailing_list }
    it { should_not be_valid }
  end

  describe "when created" do
    it "should default subscribed to true" do
      @mailing_list.subscribed.should == true
    end
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@example,com user_at_example.com user@example. user@example_site.com user@example+site.com]
      addresses.each do |invalid_address|
        @mailing_list.email = invalid_address
        @mailing_list.should_not be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be invalid" do
      addresses = %w[user@foo.COM USER_A@a.b.org user.person@example.com user+name@example.co]
      addresses.each do |valid_address|
        @mailing_list.email = valid_address
        @mailing_list.should be_valid
      end
    end
  end
end
