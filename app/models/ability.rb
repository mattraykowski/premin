class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.is_site_admin
      can :manage, :all
    end
  end
end
