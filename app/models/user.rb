class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments
  enum role: [:user, :admin]
  after_create :send_email_create_user
  before_validation :downcase_email
  CSV_ATTRIBUTES = %w(name email birthday).freeze
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #delete devise validate to custome validate
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]
  validates :name, presence: true, length: {maximum: 50, message: "name is so long, please choose short name"}, uniqueness: true
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX, message: "email is invalid"}
  validates :password, presence: true, :on => :create 

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name 
    end
  end

  private
  
  def downcase_email
  self.email = email.downcase if email.present?
  end
  
  def send_email_create_user
    UserCreateMailer.create(self).deliver_now
  end
end
