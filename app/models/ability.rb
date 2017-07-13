class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, to: :safe_actions
    case 
    when (user.has_role? :super_admin)
        can :manage, :all
    when (user.has_role? :admin)
        can :manage, AdminUser, id: user.id 
        can :manage, Article, :published => false  
        can :safe_actions, Article, :published => true     
        can :safe_actions, Category
        can :read, ActiveAdmin::Page, :name => "Dashboard"
    when (user.has_role? :moderator)
        can :manage, AdminUser, id: user.id
        can :manage, Article, :published => false
        can :read, Article, :published => true
        can :read, ActiveAdmin::Page, :name => "Dashboard"
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
