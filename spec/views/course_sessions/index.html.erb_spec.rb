require 'spec_helper'

describe "course_sessions/index" do
  before(:each) do
    assign(:course_sessions, [
      stub_model(CourseSession),
      stub_model(CourseSession)
    ])
  end

  it "renders a list of course_sessions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
