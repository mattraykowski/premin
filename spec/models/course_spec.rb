require 'spec_helper'

describe Course do
  before(:each) do
    @account = FactoryGirl.create(:account)
    @course = FactoryGirl.create(:course, account: @account)
  end
  subject { @course }

  it { should respond_to(:name) }
  it { should respond_to(:age_group) }
  it { should respond_to(:class_time_description) }
  it { should respond_to(:days_description) }
  it { should respond_to(:long_description) }
  it { should respond_to(:tuition_description) }

  describe "when name is not present" do
    before { @course.name = " " }
    it { should_not be_valid }
  end

  describe "when does not belong to account" do
    before { @course.account = nil }
    it { should_not be_valid }
  end
end
