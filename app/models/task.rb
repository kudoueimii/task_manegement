class Task < ApplicationRecord
  validates :title, presence: true
  validates :detail, presence: true
  # has_many :task_labels
  # belongs_to :users
end
