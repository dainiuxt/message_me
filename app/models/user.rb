class User < ApplicationRecord
	validates :username, presence: true, length: { minimum: 2, maximum: 25 }
	VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true,
	uniqueness: { case_sensitive: false },
	length: { maximum: 110 },
	format: { with: VALID_EMAIL }
	has_secure_password
	has_many :messages
end
