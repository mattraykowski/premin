class HomeController < ApplicationController
  layout 'public'

  def index
  end

  def oops
  end

  def about
  end

  def contact
  end

  def customers
    @accounts = Account.all
  end

  def news
  end

end
