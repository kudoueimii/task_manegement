class Task < ApplicationRecord
  validates :title, presence: true
  validates :detail, presence: true
  validates :deadline_at, presence: true
  # has_many :task_labels
  # belongs_to :users
  scope :deadline, -> {order(deadline_at: :desc)}
end
