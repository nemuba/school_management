# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    elsif user.teacher?
      can [:update, :read], User, id: user.id
      can :read, SchoolClass, user_id: user.id
      can :manage, Presence
      can [:read], Student, school_classes: {user_id: user.id}
      can :read, ActiveAdmin::Page, name: "Dashboard", namespace_name: "admin"
    end
  end
end
