require 'spec_helper'

describe Page do
  before { @page = FactoryGirl.create(:page) }

  subject { @page }

  it { should respond_to(:title) }
  it { should respond_to(:sidebar) }
  it { should respond_to(:content) }
  it { should respond_to(:account) }

  describe "when title is not present" do
    before { @page.title = " " }
    it { should_not be_valid }
  end

  describe "when content is not present" do
    before { @page.content = " " }
    it { should_not be_valid }
  end

  it "should default sidebar to false" do
    subject.sidebar.should be_false
  end

  describe "when belonging to an account" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @page.account = @user.account
      @page.save
    end

    it "should belong to an account" do
      subject.account.should == @user.account
    end
  end

end
