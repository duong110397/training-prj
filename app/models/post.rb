class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  enum status: [:non_public, :public_post]
  enum commit_status: [:waiting_status, :reject_status, :approve_status]
  validates :title, presence: true, length: {maximum: 30, message: "title is so long"}
  validates :content, presence: true
#   validates :image, content_type: [:png, :jpg, :jpeg],
#   size: { less_than: 5.megabytes,
#   message: "should be less than 5MB" }
end
