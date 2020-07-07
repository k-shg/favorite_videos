class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  has_many :comments
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: { message: "動画が存在しません" }, length: { maximum: 100 }
  validates :youtube_url, presence: { message: "動画URLを入力してください" }, length: { maximum: 100 }

  def self.search(search, category)

    if search.blank? && category.blank?
      Post.all
    else
      Post.where('title LIKE ? AND category_id = ? ', "%#{search}%", category)
    end
  end
end
