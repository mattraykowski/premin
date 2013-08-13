class MailingListController < ApplicationController
  def create
    @mailing_list = MailingList.new({email: params[:email]})

    respond_to do |format|
      if @mailing_list.save
        format.html { redirect_to root_path, notice: "Subscribed! Thank you!" }
        format.json { render json: @mailing_list, status: :created, location: root_path }
      else
        format.html { redirect_to root_path, notice: "Sorry, try a different email address" }
        format.json { render json: @mailing_list.errors, status: :unprocessable_entity }
      end
    end
  end
end
