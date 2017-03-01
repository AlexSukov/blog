class PostPolicy < ApplicationPolicy
  attr_reader :current_user, :post

  def initialize(current_user, post)
    @current_user = current_user
    @post = post
  end

  def new?
    @current_user&.admin?
  end
  
  def create?
    @current_user&.admin?
  end

  def edit?
    @current_user&.admin? || @current_user&.moderator?
  end

  def update?
    @current_user&.admin? || @current_user&.moderator?
  end

  def destroy?
      @current_user&.admin?
  end
end
