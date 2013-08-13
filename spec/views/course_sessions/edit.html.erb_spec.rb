require 'spec_helper'

describe "course_sessions/edit" do
  before(:each) do
    @course_session = assign(:course_session, stub_model(CourseSession))
  end

  it "renders the edit course_session form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", course_session_path(@course_session), "post" do
    end
  end
end
