class Task < ApplicationRecord
  validates :title, presence: true
  validates :detail, presence: true
  
  belongs_to :user
  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels, source: :label
  
  scope :deadline, -> {order(deadline_at: :desc)}
  scope :search_title, ->(title){where("title LIKE ?", "%#{title}%")}
  scope :search_status, ->(status){where(status: status)}
  enum status: {
    waiting: 0,
    working: 1,
    done: 2
  }
  enum priority: {
    高: 0,
    中: 1,
    低: 2
  }
end
