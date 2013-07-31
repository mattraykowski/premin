shared_examples "a model supporting by_account" do |obj_symbol, obj_class|
  let(:obj_symbol) { obj_symbol }
  let(:obj_class) { obj_class }
  before(:each) do
    @acct1 = @account
    @acct2 = FactoryGirl.create(:account, subdomain: @acct1.subdomain + "1")
    @obj1 = FactoryGirl.create(obj_symbol, account: @acct1)
    @obj2 = FactoryGirl.create(obj_symbol, account: @acct2)
    @obj1.save
    @obj2.save
  end

  it "includes all objects by account" do
    obj_class.by_account(@obj1.account).should include(@obj1)
  end

  it "excludes objects not in the account" do
    obj_class.by_account(@obj1.account).should_not include(@obj2)
  end
end

