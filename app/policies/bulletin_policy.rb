# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def show?
    author? || record.published? || user&.admin?
  end

  def create?
    user
  end

  def update?
    author?
  end

  def author?
    user == record.user
  end
end
