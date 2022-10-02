class Group < ApplicationRecord
  
  has_many :group_users, dependent: :destroy
  belongs_to :user
  
  has_one_attached :image
  
  validates :name, presence: true
end
