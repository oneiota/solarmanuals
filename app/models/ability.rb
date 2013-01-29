class Ability
  include CanCan::Ability

  def initialize(user)
    
    user ||= User.new
    
    can [:create, :destroy, :update, :read], Manual
    
    can :document, Manual do |manual|
      manual.paid?
    end
    
    
  end
end
