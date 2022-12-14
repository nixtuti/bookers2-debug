class Book < ApplicationRecord
  belongs_to :user
  
  validates :title, presence:true
  validates :body, presence:true, length:{maximum:200}
  
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
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
  
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
  scope :created_this_week, -> { where(created_at: 6.days.ago.beginning_of_day..Time.zone.now.end_of_day) }
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) }
  scope :created_days_ago, ->(n) { where(created_at: n.days.ago.all_day) }
  
  is_impressionable
end
