require 'spec_helper'

describe "course_sessions/new" do
  before(:each) do
    assign(:course_session, stub_model(CourseSession).as_new_record)
  end

  it "renders new course_session form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", course_sessions_path, "post" do
    end
  end
end
