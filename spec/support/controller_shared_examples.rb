#########################################
#                                       #
# SHARED CONTEXTS                       #
# Shared contexts to help set up tests. #
#                                       #
#########################################
shared_context "create empty account request" do
  before(:each) do
    @account = FactoryGirl.create(:account)
    @request.host = "#{@account.subdomain}.example.com"
  end
end

shared_context "set request host" do
  login_create_user(:user)
  let(:host) { "#{@user.account.subdomain}.example.com" }
  before { @request.host = host }
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

shared_context "basic redirect tests" do
  describe "GET index" do
    it "should redirect with flash notice" do
      unless skip_actions.include?(:index)
        get :index, {}
        subject.should redirect_to send(redirect_path)
      end
    end
  end
  describe "GET show" do
    it "should redirect with flash notice" do
      unless skip_actions.include?(:show)
        object = FactoryGirl.create(object_symbol)
        get :show, { id: object.to_param }
        subject.should redirect_to send(redirect_path)
      end
    end
  end
  describe "GET new" do
    it "should redirect with flash notice" do
      unless skip_actions.include?(:new)
        get :new, {}
        subject.should redirect_to send(redirect_path)
      end
    end
  end
  describe "GET edit" do
    it "should redirect with flash notice" do
      unless skip_actions.include?(:edit)
        object = FactoryGirl.create(object_symbol)
        get :edit, { id: object.to_param }
        subject.should redirect_to send(redirect_path)
      end
    end
  end
  describe "POST create" do
    it "should redirect with flash notice" do
      unless skip_actions.include?(:create)
        post :create, { object_symbol => FactoryGirl.attributes_for(object_symbol) }
        subject.should redirect_to send(redirect_path)
      end
    end
  end
  describe "PUT update" do
    it "should redirect with flash notice" do
      unless skip_actions.include?(:update)
        object = FactoryGirl.create(object_symbol)
        put :update, {id: object.to_param, object_symbol => { "doesntmatter" => "foobar" }}
        subject.should redirect_to send(redirect_path)
      end
    end
  end
  describe "DELETE destroy" do
    it "should redirect with flash notice" do
      unless skip_actions.include?(:destroy)
        object = FactoryGirl.create(object_symbol)
        delete :destroy, { id: object.to_param }
        subject.should redirect_to send(redirect_path)
      end
    end
  end
end
##########################################
#                                        #
# SHARED EXAMPLES                        #
# Shared examples to DRY up common tests #
#                                        #
##########################################
shared_examples "a controller requiring authentication" do |object_symbol, skip_actions|
  include_context "create empty account request"

  describe "GET index" do
    it "should redirect to login" do
      unless skip_actions.include?(:index)
        get :index, {}
        subject.should redirect_to new_user_session_path(subdomain: @account.subdomain)
      end
    end
  end
  describe "GET new" do
    it "should redirect to login" do
      unless skip_actions.include?(:new)
        get :new, {}
        subject.should redirect_to new_user_session_path(subdomain: @account.subdomain)
      end
    end
  end
  describe "GET show" do
    it "should redirect to login" do
      unless skip_actions.include?(:show)
        object = FactoryGirl.create(object_symbol)
        get :show, { id: object.to_param }
        subject.should redirect_to new_user_session_path(subdomain: @account.subdomain)
      end
    end
  end
  describe "GET edit" do
    it "should redirect to login" do
      unless skip_actions.include?(:edit)
        object = FactoryGirl.create(object_symbol)
        get :edit, { id: object.to_param }
        subject.should redirect_to new_user_session_path(subdomain: @account.subdomain)
      end
    end
  end
  describe "POST create" do
    it "should redirect to login" do
      unless skip_actions.include?(:create)
        post :create, { object_symbol => FactoryGirl.attributes_for(object_symbol) }
        subject.should redirect_to new_user_session_path(subdomain: @account.subdomain)
      end
    end
  end
  describe "PUT update" do
    it "should redirect to login" do
      unless skip_actions.include?(:update)
        object = FactoryGirl.create(object_symbol)
        put :update, {id: object.to_param, object_symbol => { "doesntmatter" => "foobar" }}
        subject.should redirect_to new_user_session_path(subdomain: @account.subdomain)
      end
    end
  end
  describe "DELETE destroy" do
    it "should redirect to login" do
      unless skip_actions.include?(:destroy)
        object = FactoryGirl.create(object_symbol)
        delete :destroy, { id: object.to_param }
        subject.should redirect_to new_user_session_path(subdomain: @account.subdomain)
      end
    end
  end
end


shared_examples "a controller requiring account subdomain" do |object_symbol, redirect_path, skip_actions=[]|
  login_create_user(:user)
  let(:object_symbol) { object_symbol }
  let(:redirect_path) { redirect_path }
  let(:skip_actions) { skip_actions }
  include_context "basic redirect tests"
end

shared_examples "a controller requiring site admin access" do |object_symbol, redirect_path, skip_actions=[]|
  before { @user.update_attribute(:is_site_admin,  false) }
  let(:object_symbol) { object_symbol }
  let(:redirect_path) { redirect_path }
  let(:skip_actions) { skip_actions }
  include_context "basic redirect tests"
end
