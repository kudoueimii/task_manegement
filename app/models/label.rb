class Label < ApplicationRecord
  validates :title, presence: true
  has_many :task_labels

end
