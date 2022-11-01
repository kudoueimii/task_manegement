class Task < ApplicationRecord
  validates :title, presence: true
  validates :detail, presence: true
  validates :deadline_at, presence: true
  # has_many :task_labels
  # belongs_to :users
  scope :deadline, -> {order(deadline_at: :desc)}
  enum status: {
    waiting: 0,
    working: 1,
    done: 2
  }
end
