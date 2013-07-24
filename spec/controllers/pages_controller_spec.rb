require 'spec_helper'

describe PagesController do

  let(:valid_attributes) { {  } }

  let(:valid_session) { {} }

  describe "when there is no subdomain" do
    describe "GET index" do
      it "should redirect to cusomters with flash notice" do
        get :index, {}
        subject.should redirect_to customers_path
      end
    end
    describe "GET show" do
      it "should redirect to cusomters with flash notice" do
        page = FactoryGirl.create(:page)
        get :show, { id: page.to_param }
        subject.should redirect_to customers_path
      end
    end
    describe "GET new" do
      it "should redirect to cusomters with flash notice" do
        get :new, {}
        subject.should redirect_to customers_path
      end
    end
    describe "GET edit" do
      it "should redirect to cusomters with flash notice" do
        page = FactoryGirl.create(:page)
        get :edit, { id: page.to_param }
        subject.should redirect_to customers_path
      end
    end
    describe "POST create" do
      it "should redirect to cusomters with flash notice" do
        post :create, { page: FactoryGirl.attributes_for(:page) }
        subject.should redirect_to customers_path
      end
    end
    describe "PUT update" do
      it "should redirect to cusomters with flash notice" do
        page = FactoryGirl.create(:page)
        put :update, {id: page.to_param, account: { "title" => "foobar" }}
        subject.should redirect_to customers_path
      end
    end
    describe "DELETE destroy" do
      it "should redirect to cusomters with flash notice" do
        page = FactoryGirl.create(:page)
        delete :destroy, { id: page.to_param }
        subject.should redirect_to customers_path
      end
    end
  end

  shared_context "create valid page" do
    login_create_user(:user)
    let(:host) { "#{@user.account.subdomain}.example.com" }
    before(:each) do
      @page = FactoryGirl.create(:page)
      @page.account = @user.account
      @page.save
      @request.host = host
    end
  end

  shared_context "set request host" do
    login_create_user(:user)
    let(:host) { "#{@user.account.subdomain}.example.com" }
    before { @request.host = host }
  end

  describe "when there is a subdomain" do
    describe "GET index" do
      include_context "create valid page"
      it "assigns all pages as @pages" do
        get :index, {}
        assigns(:pages).should eq([@page])
      end
    end

    describe "GET show" do
      include_context "create valid page"
      it "assigns the requested page as @page" do
        get :show, { id: @page.to_param } 
        assigns(:page).should eq(@page)
      end
    end

    describe "GET new" do
      include_context "set request host"
      it "assigns a new page as @page" do
        get :new, {}
        assigns(:page).should be_a_new(Page)
      end
    end

    describe "GET edit" do
      include_context "create valid page"
      it "assigns the requested page as @page" do
        get :edit, {:id => @page.to_param}
        assigns(:page).should eq(@page)
      end
    end

    describe "POST create" do
      include_context "set request host"

      describe "with valid params" do
        before { @attrs = FactoryGirl.attributes_for(:page) }

        it "creates a new Page" do
          expect {
            post :create, {:page => @attrs}
          }.to change(Page, :count).by(1)
        end

        it "assigns a newly created page as @page" do
          post :create, {:page => @attrs}
          assigns(:page).should be_a(Page)
          assigns(:page).should be_persisted
        end

        it "redirects to the created page" do
          post :create, {:page => @attrs}
          response.should redirect_to(Page.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved page as @page" do
          # Trigger the behavior that occurs when invalid params are submitted
          Page.any_instance.stub(:save).and_return(false)
          post :create, {:page => {  }}
          assigns(:page).should be_a_new(Page)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Page.any_instance.stub(:save).and_return(false)
          post :create, {:page => {  }}
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        include_context "create valid page"

        it "updates the requested page" do
          # Assuming there are no other pages in the database, this
          # specifies that the Page created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Page.any_instance.should_receive(:update_attributes).with({ "title" => "foobar" })
          put :update, {:id => @page.to_param, :page => { "title" => "foobar" }}
        end

        it "assigns the requested page as @page" do
          put :update, {:id => @page.to_param, :page => FactoryGirl.attributes_for(:page)}
          assigns(:page).should eq(@page)
        end

        it "redirects to the page" do
          put :update, {:id => @page.to_param, :page => FactoryGirl.attributes_for(:page)}
          response.should redirect_to(@page)
        end
      end

      describe "with invalid params" do
        include_context "create valid page"

        it "assigns the page as @page" do
          # Trigger the behavior that occurs when invalid params are submitted
          Page.any_instance.stub(:save).and_return(false)
          put :update, {:id => @page.to_param, :page => {  }}
          assigns(:page).should eq(@page)
        end

        it "re-renders the 'edit' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Page.any_instance.stub(:save).and_return(false)
          put :update, {:id => @page.to_param, :page => {  }}
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      include_context "create valid page"

      it "destroys the requested page" do
        expect {
          delete :destroy, {:id => @page.to_param}
        }.to change(Page, :count).by(-1)
      end

      it "redirects to the pages list" do
        delete :destroy, {:id => @page.to_param}
        response.should redirect_to(pages_url)
      end
    end
  end
end
