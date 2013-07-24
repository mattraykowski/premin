require "spec_helper"

describe PagesController do
  describe "routing" do
    let(:url) { "http://subdomain.example.com" }

    it "routes to #index" do
      get("#{url}/pages").should route_to("pages#index")
    end

    it "routes to #new" do
      get("#{url}/pages/new").should route_to("pages#new")
    end

    it "routes to #show" do
      get("#{url}/pages/1").should route_to("pages#show", :id => "1")
    end

    it "routes to #edit" do
      get("#{url}/pages/1/edit").should route_to("pages#edit", :id => "1")
    end

    it "routes to #create" do
      post("#{url}/pages").should route_to("pages#create")
    end

    it "routes to #update" do
      put("#{url}/pages/1").should route_to("pages#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("#{url}/pages/1").should route_to("pages#destroy", :id => "1")
    end

  end
end
