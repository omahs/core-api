# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :create, Donation if user.can_donate?
  end
end
