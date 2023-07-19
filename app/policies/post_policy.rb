class PostPolicy < ApplicationPolicy
  def edit?
    record.user == user
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end

  def in_one_week?
    record.created_at >= Time.current - 7.days
  end
end
