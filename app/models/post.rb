class Post < ApplicationRecord
  extend OrderAsSpecified
  belongs_to :user
  belongs_to :category, optional: true
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  has_many :comments
  accepts_nested_attributes_for :comments
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: { message: "動画が存在しません" }, length: { maximum: 100 }
  validates :youtube_url, presence: { message: "動画URLを入力してください" }, length: { maximum: 11 }
  attr_accessor :channel_title

  def self.search(params)
    search = params[:search]
    category = params[:category_id]
    order = params[:order]
    order_condition = (order == "1") ? "DESC": "ASC"
    #いいねが多い順にソートされた動画IDリスト
    ids = Like.group(:post_id).order(Arel.sql("count(post_id) #{order_condition}")).pluck(:post_id)
    posts = Post.unscope(:order).where(id: ids).order_as_specified(id: ids)

    # ----------------------条件なし----------------------
    if search.blank? && category.blank? && order.blank?
       Post.all

    # ----------------------単数指定----------------------
    # 検索ワードのみ指定
    elsif search.present? && category.blank? && order.blank?
      Post.where('title LIKE ?', "%#{search}%")
    # カテゴリーのみ指定
    elsif search.blank? && category.present? && order.blank?
      Post.where('category_id = ?', category)
    # 順序のみ指定
    elsif search.blank? && category.blank? && order.present?
      posts

    # ----------------------複数指定----------------------
    # 検索ワード、カテゴリー指定
    elsif search.present? && category.present? && order.blank?
      Post.where('title LIKE ? AND category_id = ?', "%#{search}%", category)
    #検索ワード、順序指定
    elsif search.present? && category.blank? && order.present?
      posts.where('title LIKE ?', "%#{search}%")
    # カテゴリー、順序指定
    elsif search.blank? && category.present? && order.present?
      posts.where('category_id = ?', category)

    # ----------------------条件全指定----------------------
    else
      posts.where('title LIKE ? AND category_id = ?', "%#{search}%", category)
    end
  end
end
