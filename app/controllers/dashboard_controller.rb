class DashboardController < ApplicationController
  before_filter :requires_current_account

  def index
    @pages = Page.by_account(@current_account).sidebars
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end

  def public
    @pages = Page.by_account(@current_account).sidebars
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end
end
