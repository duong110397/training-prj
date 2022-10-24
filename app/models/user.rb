class User < ApplicationRecord
  enum role: [:user, :admin]
  after_create :send_email_create_user
  before_validation :downcase_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #delete devise validate to custome validate
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  validates :name, presence: true, length: {maximum: 50, message: "name is so long, please choose short name"}, uniqueness: true
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX, message: "email is invalid"}
  validates :password, presence: true
  private
  
  def downcase_email
  self.email = email.downcase if email.present?
  end
  
  def send_email_create_user
    UserCreateMailer.create(self).deliver_now
  end
end
