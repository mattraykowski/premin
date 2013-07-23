require 'spec_helper'

describe AccountsController do
  describe "GET index" do
    it "assigns all accounts as @accounts" do
      get :index, {}
      assigns(:accounts).should eq(Account.all)
    end
  end

  describe "while not authenticated" do
    describe "GET show" do
      it "should redirect  to sign in" do
        account = FactoryGirl.create(:account)
        get :show, {:id => account.to_param}
        subject.should redirect_to new_user_session_path
      end
    end

    describe "GET new" do
      it "should redirect to sign in" do
        get :new, {}
        subject.should redirect_to new_user_session_path
      end
    end
    describe "GET edit" do
      it "should redirect to sign in" do
        account = FactoryGirl.create(:account)
        get :edit, {:id => account.to_param}
        subject.should redirect_to new_user_session_path
      end
    end
    describe "POST create" do
      it "should redirect to sign in" do
        get :new, {}
        subject.should redirect_to new_user_session_path
      end
    end
    describe "PUT update" do
      it "should redirect to sign in" do
        account = FactoryGirl.create(:account)
        put :update, {:id => account.to_param, :account => { "subdomain" => "MyString" }}
        subject.should redirect_to new_user_session_path
      end
    end
    describe "DELETE destroy" do
      it "should redirect to sign in" do
        get :new, {}
        subject.should redirect_to new_user_session_path
      end
    end
  end # while not authenticated

  describe "while authenticated" do
    login_create_user :user
    describe "GET new" do
      it "should redirect to 'oops'" do
        get :new, {}
        subject.should redirect_to '/oops'
      end
    end

    describe "POST create" do
      it "should redirect to 'oops'" do
        post :create, {:account => FactoryGirl.attributes_for(:account)}
        subject.should redirect_to '/oops'
      end
    end

    describe "DELETE destroy" do
      it "redirects to the accounts list" do
        delete :destroy, {:id => @user.account.to_param}
        subject.should redirect_to '/oops'
      end
    end
  end # while authenticated

  describe "while authenticated as a non-owner" do
      login_create_user :user
      before(:each) do
        @user_owner = FactoryGirl.create(:user,
                                         email: "aaa" + @user.email,
                                         account_subdomain: @user.account.subdomain + "1", 
                                         account_name: @user.account.name + "1")
        @account = @user_owner.account
      end

    describe "GET edit" do
      it "should redirect to 'oops'" do
        get :edit, {:id => @account.to_param}
        subject.should redirect_to '/oops'
      end
    end
    describe "PUT update" do
      it "should redirect to 'oops'" do
        account = FactoryGirl.create(:account)
        put :update, {:id => account.to_param, :account => { "subdomain" => "MyString" }}
        subject.should redirect_to '/oops'
      end
    end
    describe "DELETE destroy" do
      it "should redirect to 'oops'" do
        account = FactoryGirl.create(:account)
        delete :destroy, {:id => account.to_param}
        subject.should redirect_to '/oops'
      end
    end

  end # authenticated as a non-owner.

  describe "while authenticated as the owner" do
    before(:each) do 
      user = FactoryGirl.create(:user)
      @account = user.account
    end
    login_existing_user :user

    describe "GET show" do
      it "assigns the requested account as @account" do
        get :show, {:id => @account.to_param}
        assigns(:account).should eq(@account)
      end
    end

    describe "GET edit" do
      it "assigns the requested account as @account" do
        get :edit, {:id => @account.to_param}
        assigns(:account).should eq(@account)
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested account" do
          Account.any_instance.should_receive(:update_attributes).with({ "subdomain" => "newsubdomain" })
          put :update, {:id => @account.to_param, :account => { "subdomain" => "newsubdomain" }}
        end

        it "assigns the requested account as @account" do
          put :update, {:id => @account.to_param, :account => FactoryGirl.attributes_for(:account)}
          assigns(:account).should eq(@account)
        end

        it "redirects to the account" do
          put :update, {:id => @account.to_param, :account => FactoryGirl.attributes_for(:account) }
          response.should redirect_to(@account)
        end
      end

      describe "with invalid params" do
        it "assigns the account as @account" do
          # Trigger the behavior that occurs when invalid params are submitted
          Account.any_instance.stub(:save).and_return(false)
          put :update, {:id => @account.to_param, :account => { "subdomain" => "invalid value" }}
          assigns(:account).should eq(@account)
        end

        it "re-renders the 'edit' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Account.any_instance.stub(:save).and_return(false)
          put :update, {:id => @account.to_param, :account => { "subdomain" => "invalid value" }}
          response.should render_template("edit")
        end
      end
    end

  end # while authenticated as the owner
end
