class Favorite < ApplicationRecord
  
  belongs_to :user
  belongs_to :book
  
  #バリデーション　ユーザーは一つの投稿に一つしかいいねできないこと
  validates_uniqueness_of :book_id, scope: :user_id
  
end
