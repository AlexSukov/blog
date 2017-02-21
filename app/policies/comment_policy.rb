class CommentPolicy < ApplicationPolicy
  attr_reader :current_user, :comment

  def initialize(current_user, comment)
    @current_user = current_user
    @comment = comment
  end

  def edit?
      @current_user&.admin? || @current_user&.moderator? || (@comment.user_id == @current_user && @current_user&.user?)
  end

  def update?
      @current_user&.admin? || @current_user&.moderator? || (@comment.user_id == @current_user && @current_user&.user?)
  end

  def destroy?
        @current_user&.admin? || @current_user&.moderator? || (@comment.user_id == @current_user && @current_user&.user?)
  end
end
