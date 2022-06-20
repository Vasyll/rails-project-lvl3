# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    author? || record.published?
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
