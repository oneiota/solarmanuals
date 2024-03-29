class Ability
  include CanCan::Ability

  def initialize(user)
    
    user ||= User.new
    
    can :create, Manual
    
    can [:destroy, :update, :read, :set_feature, :duplicate], Manual do |manual|
      manual.user == user || user.insider
    end
    
    can :document, Manual do |manual|
      manual.paid? || manual.user.subscribed? || user.insider
    end
    
    can :manage, User do |other_user|
      user == other_user
    end
    
    
  end
end
