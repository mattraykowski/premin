class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_account, :is_root_domain?, :can_sign_up?
  before_filter :current_account

  def can_sign_up?
    is_root_domain? ? true : Account::CAN_SIGN_UP
  end

  def is_root_domain?
    # return true if there is no subdomain
    (request.subdomains.first.present? && request.subdomains.first != "www") ? false : true
  end

  def current_account
    if is_root_domain?
      @current_account = nil 
    else
      @current_account ||= Account.find_by_subdomain(request.subdomains.first)
      if @current_account.nil?
        redirect_to root_url(account: false, alert: "Unknown account/subdomain")
      end
    end
    @current_account
  end

  def is_account_resource?(account_id)
    if account_id != current_account.id
      redirect_to '/oops', alert: "Sorry, that resource is not part of your account."
    end
  end

  #def authenticate_user!(opt={})
  #  unless user_signed_in?
  #    redirect_to root_url, :alert => "You must be logged in to access that page."
  #    return false;
  #  end
  #end

  def requires_current_account
    if @current_account.nil?
      flash.now[:notice] = "You must be logged in to a school to do that."
      redirect_to customers_path
    end 
  end
  
  def requires_site_admin
    if user_signed_in? && current_user.account == @current_account && current_user.is_site_admin
      return
    end

    flash.now[:alert] = "You do not have access to that page!"
    redirect_to oops_path
  end
end
