# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  aasm column: 'state', whiny_transitions: false do
    state :draft, initial: true
    state :under_moderation
    state :published
    state :rejected
    state :archived

    event :to_moderate do
      transitions from: %i[draft rejected], to: :under_moderation
    end

    event :publish do
      transitions from: :under_moderation, to: :published
    end

    event :reject do
      transitions from: :under_moderation, to: :rejected
    end

    event :archive do
      transitions from: %i[draft under_moderation published rejected archived], to: :archived
    end
  end

  belongs_to :user
  belongs_to :category

  has_one_attached :image

  validates :description, presence: true, length: { maximum: 1000 }
  validates :image, presence: true,
                    attached: true,
                    content_type: %i[png jpg jpeg],
                    size: { less_than: 5.megabytes }
  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
end
