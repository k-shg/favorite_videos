class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :content, presence: true, length: { maximum: 600 }
  validates :title, presence: true, length: { maximum: 100 }
  validates :rate, presence: true
end
