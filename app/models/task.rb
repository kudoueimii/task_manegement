class Task < ApplicationRecord
  validates :title, presence: true
  validates :detail, presence: true
  validates :deadline, presence: true
  # has_many :task_labels
  # belongs_to :users
end
