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


  describe "by_account" do
    before(:each) do
      @acct1 = FactoryGirl.create(:account)
      @acct2 = FactoryGirl.create(:account, subdomain: @acct1.subdomain + "1")
      @page1 = FactoryGirl.create(:page, account: @acct1)
      @page2 = FactoryGirl.create(:page, account: @acct2)
      @page1.save
      @page2.save
    end
    it "includes pages by account" do
      Page.by_account(@page1.account).should include(@page1)
    end
    it "excludes pages not in the account" do
      Page.by_account(@page1.account).should_not include(@page2)
    end
  end
end
