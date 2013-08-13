require 'spec_helper'

describe CoursesController do
  describe "authentication" do
    include_context "create empty account request"
    it_should_behave_like "a controller requiring authentication", :course, [:show, :index], true
  end
  describe "subdomain" do
    it_should_behave_like "a controller requiring account subdomain", :course, :customers_path, [], true
  end

  #let(:valid_attributes) { {  } }

  describe "when there is a subdomain" do
    describe "GET index" do
      include_context "set request host"
      before(:each) do
        @course = FactoryGirl.create(:course, account: @user.account)
      end

      it "assigns all courses as @courses" do
        get :index, {}
        assigns(:courses).should eq([@course])
      end
    end

    describe "GET show" do
      include_context "set request host"
      before(:each) do
        @course = FactoryGirl.create(:course, account: @user.account)
      end

      it "assigns the requested course as @course" do
        get :show, {:id => @course.to_param}
        assigns(:course).should eq(@course)
      end
    end

    describe "when is not a site admin" do
      include_context "create valid course"
      it_should_behave_like "a controller requiring site admin access", :course, :oops_path, [:index, :show], true
    end

    describe "when is a site admin" do
      describe "GET new" do
        include_context "set request host"
        it "assigns a new course as @course" do
          get :new, {}
          assigns(:course).should be_a_new(Course)
        end
      end

      describe "GET edit" do
        include_context "create valid course"
        it "assigns the requested course as @course" do
          get :edit, {:id => @course.to_param}
          assigns(:course).should eq(@course)
        end
      end

      describe "POST create" do
        include_context "set request host"
        describe "with valid params" do
          before { @attrs = FactoryGirl.attributes_for(:course) }

          it "creates a new Course" do
            expect {
              post :create, {:course => @attrs}
            }.to change(Course, :count).by(1)
          end

          it "assigns a newly created course as @course" do
            post :create, {:course => @attrs}
            assigns(:course).should be_a(Course)
            assigns(:course).should be_persisted
          end

          it "redirects to the created course" do
            post :create, {:course => @attrs}
            response.should redirect_to courses_path
          end
        end

        describe "with invalid params" do
          it "assigns a newly created but unsaved course as @course" do
            # Trigger the behavior that occurs when invalid params are submitted
            Course.any_instance.stub(:save).and_return(false)
            post :create, {:course => {  }}
            assigns(:course).should be_a_new(Course)
          end
    
          it "re-renders the 'new' template" do
            # Trigger the behavior that occurs when invalid params are submitted
            Course.any_instance.stub(:save).and_return(false)
            post :create, {:course => {  }}
            response.should render_template("new")
          end
        end
      end

      describe "PUT update" do
        include_context "create valid course"

        describe "with valid params" do
          it "updates the requested course" do
            # Assuming there are no other courses in the database, this
            # specifies that the Course created on the previous line
            # receives the :update_attributes message with whatever params are
            # submitted in the request.
            Course.any_instance.should_receive(:update_attributes).with({ "name" => "some name" })
            put :update, {:id => @course.to_param, :course => { "name" => "some name" }}
          end

          it "assigns the requested course as @course" do
            put :update, {:id => @course.to_param, :course => FactoryGirl.attributes_for(:course)}
            assigns(:course).should eq(@course)
          end

          it "redirects to the course" do
            put :update, {:id => @course.to_param, :course => FactoryGirl.attributes_for(:course)}
            response.should redirect_to courses_path
          end
        end

        describe "with invalid params" do
          it "assigns the course as @course" do
            # Trigger the behavior that occurs when invalid params are submitted
            Course.any_instance.stub(:save).and_return(false)
            put :update, {:id => @course.to_param, :course => {  }}
            assigns(:course).should eq(@course)
          end

          it "re-renders the 'edit' template" do
            # Trigger the behavior that occurs when invalid params are submitted
            Course.any_instance.stub(:save).and_return(false)
            put :update, {:id => @course.to_param, :course => {  }}
            response.should render_template("edit")
          end
        end
      end

      describe "DELETE destroy" do
        include_context "set request host"
        before(:each) do
          @course = FactoryGirl.create(:course, account: @user.account)
        end

        it "destroys the requested course" do
          expect {
            delete :destroy, {:id => @course.to_param}
          }.to change(Course, :count).by(-1)
        end

        it "redirects to the courses list" do
          delete :destroy, {:id => @course.to_param}
          response.should redirect_to(courses_url)
        end
      end
    end
  end
end
