require 'spec_helper'

describe "course_sessions/show" do
  before(:each) do
    @course_session = assign(:course_session, stub_model(CourseSession))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
