class Group < ApplicationRecord
  
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  #不足
  belongs_to :owner, class_name: 'User'
  
  has_one_attached :group_image
  
  validates :name, presence: true
  
  def get_group_image
    (group_image.attached?) ? group_image : 'no_image.jpg'
  end
  
end
