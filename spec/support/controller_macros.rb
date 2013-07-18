module ControllerMacros    
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryGirl.create(:user)
      sign_in @user
    end
  end
  def login_account_owner
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user_owning_account]
      @account_owned = FactoryGirl.create(:account_owned)
      @user_owning_account = FactoryGirl.create(:user_owning_account)
      @account_owned.owner = @user_owning_account
      @account_owned.save
      #@user_owning_account.account = @account_owned
      #@user_owning_account.save
      sign_in @user_owning_account
    end
  end
end
