class Post < ApplicationRecord
  acts_as_votable
  belongs_to :user, required: false
  has_many :comments, dependent: :destroy
  has_one_attached :image
  enum status: [:non_public, :public_post]
  enum commit_status: [:waiting_status, :reject_status, :approve_status]
  validates :title, presence: true, length: {maximum: 30, message: "title is so long"}
  validates :content, presence: true
end
