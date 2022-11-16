class Comment < ApplicationRecord
  belongs_to :user, required: false
  belongs_to :post
  validates :content, presence: true
end
