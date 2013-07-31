require 'spec_helper'

describe Page do
  before(:each) do
    @account = FactoryGirl.create(:account)
    @page = FactoryGirl.create(:page)
  end

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
      @page.account = @account
      @page.save
    end

    it "should belong to an account" do
      subject.account.should == @account
    end
  end

  it_should_behave_like "a model supporting by_account", :page, Page

  describe "sidebars" do
    before(:each) do
      @page1 = FactoryGirl.create(:page, sidebar: true)
      @page2 = FactoryGirl.create(:page, sidebar: false)
    end

    it "should include sidebar pages" do
      Page.sidebars.should include(@page1)
    end
    it "should not include non-sidebar pages" do
      Page.sidebars.should_not include(@page2)
    end
  end
end
