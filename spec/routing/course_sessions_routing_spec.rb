require "spec_helper"

describe CourseSessionsController do
  describe "routing" do
    let(:url) { "http://subdomain.example.com" }

    it "routes to #index" do
      get("#{url}/courses/1/course_sessions").should route_to("course_sessions#index", course_id: "1")
    end

    it "routes to #new" do
      get("#{url}/courses/1/course_sessions/new").should route_to("course_sessions#new", course_id: "1")
    end

    it "routes to #show" do
      get("#{url}/courses/1/course_sessions/1").should route_to("course_sessions#show", course_id: "1", id: "1")
    end

    it "routes to #edit" do
      get("#{url}/courses/1/course_sessions/1/edit").should route_to("course_sessions#edit", course_id: "1", id: "1")
    end

    it "routes to #create" do
      post("#{url}/courses/1/course_sessions").should route_to("course_sessions#create", course_id: "1")
    end

    it "routes to #update" do
      put("#{url}/courses/1/course_sessions/1").should route_to("course_sessions#update", course_id: "1", id: "1")
    end

    it "routes to #destroy" do
      delete("#{url}/courses/1/course_sessions/1").should route_to("course_sessions#destroy", course_id: "1", id: "1")
    end

  end
end
