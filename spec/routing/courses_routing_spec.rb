require "spec_helper"

describe CoursesController do
  describe "routing" do
    let(:url) { "http://subdomain.example.com" }

    it "routes to #index" do
      get("#{url}/courses").should route_to("courses#index")
    end

    it "routes to #new" do
      get("#{url}/courses/new").should route_to("courses#new")
    end

    it "routes to #show" do
      get("#{url}/courses/1").should route_to("courses#show", :id => "1")
    end

    it "routes to #edit" do
      get("#{url}/courses/1/edit").should route_to("courses#edit", :id => "1")
    end

    it "routes to #create" do
      post("#{url}/courses").should route_to("courses#create")
    end

    it "routes to #update" do
      put("#{url}/courses/1").should route_to("courses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("#{url}/courses/1").should route_to("courses#destroy", :id => "1")
    end

  end
end
