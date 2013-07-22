class HomeController < ApplicationController
  layout 'public'

  def index
  end

  def customers
    @accounts = Account.all
  end
end
