class Ability
  include CanCan::Ability

  def initialize(user)
    if user.blank?
      can :create, Session
      can :create, User
    else
      can :create, Budget
      can :destroy, Session
    end
  end
end
