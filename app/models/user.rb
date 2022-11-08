class User < ApplicationRecord
  before_validation { email.downcase! }
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  
  has_secure_password
  validates :password, length: { minimum: 6 }
  
  has_many :tasks, dependent: :destroy
  before_destroy :destroy_action
  before_destroy :update_action

  private

  def destroy_action
    if User.where(admin:true).count == 1 && self.admin == true
      throw :abort
    end
  end
  
  def update_action
    if User.where(admin: true).count == 1 && self.admin == false
      throw(:abort) 
    end
  end
end