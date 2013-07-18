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
  end

  describe "while authenticated as a non-owner" do
    login_user

    describe "GET new" do
      it "should redirect to 'oops'" do
        get :new, {}
        subject.should redirect_to '/oops'
      end
    end
    describe "GET edit" do
      it "should redirect to 'oops'" do
        account = FactoryGirl.create(:account)
        get :edit, {:id => account.to_param}
        subject.should redirect_to '/oops'
      end
    end
    describe "POST create" do
      it "should redirect to 'oops'" do
        post :create, {:account => FactoryGirl.attributes_for(:account)}
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

  end

  describe "while authenticated as the owner" do
    login_account_owner

    describe "GET show" do
      it "assigns the requested account as @account" do
        account = FactoryGirl.create(:account)
        get :show, {:id => account.to_param}
        assigns(:account).should eq(account)
      end
    end

    describe "GET new" do
      it "assigns a new account as @account" do
        get :new, {}
        assigns(:account).should be_a_new(Account)
      end
    end

    describe "GET edit" do
      it "assigns the requested account as @account" do
        account = FactoryGirl.create(:account)
        get :edit, {:id => account.to_param}
        assigns(:account).should eq(account)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Account" do
          expect {
            post :create, {:account => FactoryGirl.attributes_for(:account)}
          }.to change(Account, :count).by(1)
        end
  
        it "assigns a newly created account as @account" do
          post :create, {:account => FactoryGirl.attributes_for(:account)}
          assigns(:account).should be_a(Account)
          assigns(:account).should be_persisted
        end
  
        it "redirects to the created account" do
          post :create, {:account => FactoryGirl.attributes_for(:account)}
          response.should redirect_to(Account.last)
        end
      end
  
      describe "with invalid params" do
        it "assigns a newly created but unsaved account as @account" do
          # Trigger the behavior that occurs when invalid params are submitted
          Account.any_instance.stub(:save).and_return(false)
          post :create, {:account => { "subdomain" => "invalid value" }}
          assigns(:account).should be_a_new(Account)
        end
  
        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Account.any_instance.stub(:save).and_return(false)
          post :create, {:account => { "subdomain" => "invalid value" }}
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested account" do
          account = FactoryGirl.create(:account)
          Account.any_instance.should_receive(:update_attributes).with({ "subdomain" => "MyString" })
          put :update, {:id => account.to_param, :account => { "subdomain" => "MyString" }}
        end

        it "assigns the requested account as @account" do
          account = FactoryGirl.create(:account)
          put :update, {:id => account.to_param, :account => FactoryGirl.attributes_for(:account)}
          assigns(:account).should eq(account)
        end

        it "redirects to the account" do
          account = FactoryGirl.create(:account)
          put :update, {:id => account.to_param, :account => FactoryGirl.attributes_for(:account) }
          response.should redirect_to(account)
        end
      end

      describe "with invalid params" do
        it "assigns the account as @account" do
          account = FactoryGirl.create(:account)
          # Trigger the behavior that occurs when invalid params are submitted
          Account.any_instance.stub(:save).and_return(false)
          put :update, {:id => account.to_param, :account => { "subdomain" => "invalid value" }}
          assigns(:account).should eq(account)
        end

        it "re-renders the 'edit' template" do
          account = FactoryGirl.create(:account)
          # Trigger the behavior that occurs when invalid params are submitted
          Account.any_instance.stub(:save).and_return(false)
          put :update, {:id => account.to_param, :account => { "subdomain" => "invalid value" }}
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested account" do
        account = FactoryGirl.create(:account)
        expect {
          delete :destroy, {:id => account.to_param}
        }.to change(Account, :count).by(-1)
      end

      it "redirects to the accounts list" do
        account = FactoryGirl.create(:account)
        delete :destroy, {:id => account.to_param}
        response.should redirect_to(accounts_url)
      end
    end
  end
end
