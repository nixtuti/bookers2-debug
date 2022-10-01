class Book < ApplicationRecord
  belongs_to :user
  
  validates :title, presence:true
  validates :body, presence:true, length:{maximum:200}
  
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  #検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      Book.where(["title LIKE? OR body LIKE?", "#{word}", "#{word}"])
    elsif search == "forward_match"
      Book.where(["title LIKE? OR body LIKE?", "#{word}%", "#{word}%"])
    elsif search == "backward_match"
      Book.where(["title LIKE? OR body LIKE?", "%#{word}", "%#{word}"])
    elsif search == "partial_match"
      Book.where(["title LIKE? OR body LIKE?", "%#{word}%", "%#{word}%"])
    else
      Book.all
    end
  end
  
end
