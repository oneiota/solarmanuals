class Ability
  include CanCan::Ability

  def initialize(user)
    
    user ||= User.new
    
    can [:create, :destroy, :update, :read, :set_feature], Manual
    
    can :document, Manual do |manual|
      manual.paid? || manual.user.subscribed? || manual.user.insider
    end
    
    can :manage, User do |other_user|
      user == other_user
    end
    
    
  end
end
