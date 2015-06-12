# Admin Ability
class AdminAbility
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.super_admin?
      can :manage, :all
    elsif user.admin?
      can :manage, :all
      cannot :manage, User
    else
      cannot :manage, :all
    end
  end
end
