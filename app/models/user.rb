class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #delete devise validate to custome validate
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  validates :name, presence: true, length: {maximum: 50, message: "name is so long, please choose short name"} 
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX, message: "email is invalid"}, uniqueness: {case_sensetive:true}
  validates :password, presence: true
end
