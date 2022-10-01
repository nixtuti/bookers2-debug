class PostComment < ApplicationRecord
  
  belongs_to :book
  belongs_to :user
  
  #バリデーション　カラムが空の時は保存しない
  validates :comment, presence:true
  
end
