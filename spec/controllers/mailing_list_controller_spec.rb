require 'spec_helper'

describe MailingListController do
  describe "POST create" do
    describe "with valid params" do
      before { @attrs = FactoryGirl.attributes_for(:mailing_list) }

      it "creates a new MailingList" do
        expect {
          post :create, {:email => @attrs[:email]}
        }.to change(MailingList, :count).by(1)
      end
 
      it "assigns a newly created mailing list as @mailing_list" do
        post :create, {:email => @attrs[:email]}
        assigns(:mailing_list).should be_a(MailingList)
        assigns(:mailing_list).should be_persisted
      end

      it "redirects to the root path" do
        post :create, {:email => @attrs[:email]}
        response.should redirect_to root_path
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved mailing_list entry as @mailing_list" do
        # Trigger the behavior that occurs when invalid params are submitted
        MailingList.any_instance.stub(:save).and_return(false)
        post :create, {:mailing_list => {  }}
        assigns(:mailing_list).should be_a_new(MailingList)
      end

      it "should redirect to root path" do
        # Trigger the behavior that occurs when invalid params are submitted
        MailingList.any_instance.stub(:save).and_return(false)
        post :create, {:mailing_list => {  }}
        response.should redirect_to root_path
      end
    end
  end
end
