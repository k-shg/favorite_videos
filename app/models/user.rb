class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :comments
  has_many :active_relationships, class_name:  "Relationship",
                                foreign_key: "follower_id",
                                dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  before_save :downcase_email
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255},
              format: {with: VALID_EMAIL_REGEX},
              uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  mount_uploader :image, ImageUploader
  validate  :image_size


  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end


  def feed
    Post.all
  end

  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end

  # ユーザーをフォローする
 def follow(other_user)
   following << other_user
 end

 # ユーザーをフォロー解除する
 def unfollow(other_user)
   active_relationships.find_by(followed_id: other_user.id).destroy
 end

 # 現在のユーザーがフォローしてたらtrueを返す
 def following?(other_user)
   following.include?(other_user)
 end

    private

    # アップロードされた画像のサイズをバリデーションする
      def image_size
        if image.size > 5.megabytes
          errors.add(:image, "should be less than 5MB")
        end
      end

      def downcase_email
        email.downcase!
      end

end
