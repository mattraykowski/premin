require 'spec_helper'

describe CourseSessionsController do
  describe "authentication" do
    include_context "create empty account request"
    before { @course = FactoryGirl.create(:course, account: @account) }
    it_should_behave_like "a controller requiring authentication", :course_session, [:show, :index], false, true
  end

  describe "subdomain" do
    before(:each) do 
      @account = FactoryGirl.create(:account)
      @course = FactoryGirl.create(:course, account: @account)
    end
    it_should_behave_like "a controller requiring account subdomain", :course_session, :customers_path, [], false, true
  end

  describe "when there is a subdomain" do
    describe "GET index" do
      include_context "set request host"
      before(:each) do
        @course = FactoryGirl.create(:course, account: @user.account)
        @course_session = FactoryGirl.create(:course_session, course: @course)
      end

      it "assigns all course_sessions as @course_sessions" do
        get :index, {course_id: @course.id}
        assigns(:course_sessions).should eq([@course_session])
      end
    end

    describe "GET show" do
      include_context "set request host"
      before(:each) do
        @course = FactoryGirl.create(:course, account: @user.account)
        @course_session = FactoryGirl.create(:course_session, course: @course)
      end

      it "assigns the requested course_session as @course_session" do
        get :show, {course_id: @course.id, id: @course_session.to_param}
        assigns(:course_session).should eq(@course_session)
      end
    end

    describe "when is not a site admin" do
    end

    describe "when is a site admin" do
      describe "GET new" do
        include_context "set request host"
        before { @course = FactoryGirl.create(:course, account: @user.account) }
        it "assigns a new course_session as @course_session" do
          get :new, {course_id: @course.id}
          assigns(:course_session).should be_a_new(CourseSession)
        end
      end

      describe "GET edit" do
        include_context "set request host"
        before(:each) do
          @course = FactoryGirl.create(:course, account: @user.account)
          @course_session = FactoryGirl.create(:course_session, course: @course)
        end

        it "assigns the requested course_session as @course_session" do
          get :edit, {course_id: @course.id, id: @course_session.to_param}
          assigns(:course_session).should eq(@course_session)
        end
      end

      describe "POST create" do
        include_context "set request host"
        describe "with valid params" do
          before(:each) do
            @attrs = FactoryGirl.attributes_for(:course_session)
            @course = FactoryGirl.create(:course, account: @user.account)
          end

          it "creates a new CourseSession" do
            expect {
              post :create, {course_id: @course.id, course_session: @attrs}
            }.to change(CourseSession, :count).by(1)
          end

          it "assigns a newly created course_session as @course_session" do
            post :create, {course_id: @course.id, course_session: @attrs}
            assigns(:course_session).should be_a(CourseSession)
            assigns(:course_session).should be_persisted
          end

          it "redirects to the created course_session" do
            post :create, {course_id: @course.id, course_session: @attrs}
            response.should redirect_to(course_course_session_path(@course, CourseSession.last))
          end
        end

        describe "with invalid params" do
          before {  @course = FactoryGirl.create(:course, account: @user.account) }
          it "assigns a newly created but unsaved course_session as @course_session" do
            # Trigger the behavior that occurs when invalid params are submitted
            CourseSession.any_instance.stub(:save).and_return(false)
            post :create, {course_id: @course.id, course_session: {  }}
            assigns(:course_session).should be_a_new(CourseSession)
          end

          it "re-renders the 'new' template" do
            # Trigger the behavior that occurs when invalid params are submitted
            CourseSession.any_instance.stub(:save).and_return(false)
            post :create, {course_id: @course.id, course_session: {  }}
            response.should render_template("new")
          end
        end
      end

      describe "PUT update" do
        include_context "set request host"
        before(:each) do
          @course = FactoryGirl.create(:course, account: @user.account)
          @course_session = FactoryGirl.create(:course_session, course: @course)
        end

        describe "with valid params" do
          it "updates the requested course_session" do
            # Assuming there are no other course_sessions in the database, this
            # specifies that the CourseSession created on the previous line
            # receives the :update_attributes message with whatever params are
            # submitted in the request.
            CourseSession.any_instance.should_receive(:update_attributes).with({ "name" => "updated name" })
            put :update, {course_id: @course.id, id: @course_session.to_param, course_session: { "name" => "updated name" }}
          end

          it "assigns the requested course_session as @course_session" do
            put :update, {course_id: @course.id, id: @course_session.to_param, course_session: FactoryGirl.attributes_for(:course_session)}
            assigns(:course_session).should eq(@course_session)
          end

          it "redirects to the course_session" do
            put :update, {course_id: @course.id, id: @course_session.to_param, course_session: FactoryGirl.attributes_for(:course_session)}
            response.should redirect_to(course_course_session_path(@course, @course_session))
          end
        end

        describe "with invalid params" do
          it "assigns the course_session as @course_session" do
            # Trigger the behavior that occurs when invalid params are submitted
            CourseSession.any_instance.stub(:save).and_return(false)
            put :update, {course_id: @course.id, id: @course_session.to_param, course_session: {  }}
            assigns(:course_session).should eq(@course_session)
          end

          it "re-renders the 'edit' template" do
            # Trigger the behavior that occurs when invalid params are submitted
            CourseSession.any_instance.stub(:save).and_return(false)
            put :update, {course_id: @course.id, id: @course_session.to_param, course_session: {  }}
            response.should render_template("edit")
          end
        end
      end

      describe "DELETE destroy" do
        include_context "set request host"
        before(:each) do
          @course = FactoryGirl.create(:course, account: @user.account)
          @course_session = FactoryGirl.create(:course_session, course: @course)
        end

        it "destroys the requested course_session" do
          expect {
            delete :destroy, {course_id: @course.id, id: @course_session.to_param}
          }.to change(CourseSession, :count).by(-1)
        end

        it "redirects to the course_sessions list" do
          delete :destroy, {course_id: @course.id, id: @course_session.to_param}
          response.should redirect_to(course_url(@course))
        end
      end
    end
  end
end
