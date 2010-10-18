class Ability
  include CanCan::Ability
  
  def initialize(user)
    # user comes from current_user (see ApplicationController)
    # it points to a User object, either from the db or new (guest)
    
    if user.role? :admin
      can :manage, :all
    else
      if user.role? :tixer
        can :manage, [Show, Ticketsection, Ticketrez, Rezlineitem]
      end
      if user.role? :dev
        can :manage, [Content, Rezlineitem, Show, Ticketrez, Ticketsection, Update]
      end
      if user.role? :writer
        can :manage, [Show, Update, Content]
      end
      # normal schmucks who don't log in
      can :read, [Show, Update, Content]
      can :create, [Ticketrez, Rezlineitem]
    end
  end
end
