require 'spec_helper'

describe CourseSession do
  before(:each) do
    @account = FactoryGirl.create(:account)
    @course = FactoryGirl.create(:course, account: @account)
    @session = FactoryGirl.create(:course_session, course: @course)
  end

  subject { @session }

  it { should respond_to(:name) }
  it { should respond_to(:status) }
  it { should respond_to(:total_capacity) }
  it { should respond_to(:waitlist_capacity) }
  it { should respond_to(:course) }

  describe "when name is not present" do
    before { @session.name = " " }
    it { should_not be_valid }
  end

  describe "when does not belong to a course" do
    before { @session.course = nil }
    it { should_not be_valid }
  end

  describe "when status is a valid value" do
    it "should be valid" do
      (0..3).each do |status|
        @session.status = status
        @session.should be_valid
      end
    end
  end

  describe "when status is an invalid value" do
    it "should be invalid" do
      (997..1000).each do |status|
        @session.status = status
        @session.should_not be_valid
      end
    end
  end
  
  it_should_behave_like "a model supporting by_course", :course_session, CourseSession
  
end
