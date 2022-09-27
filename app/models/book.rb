class Book < ApplicationRecord
  belongs_to :user
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  #検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title_LIKE?", "#{word}")
    elsif search == "forward_match"
      @book = Book.where("title_LIKE?", "#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title_LIKE?", "%#{word}")
    elsif search == "partial_match"
      @book = Book.where(["title_LIKE? OR body_LIKE?", "%#{word}%", "%#{word}%"])
    else
      @book = Book.all
    end
  end
  
end
