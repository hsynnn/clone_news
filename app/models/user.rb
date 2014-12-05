class User < ActiveRecord::Base
	include Gravtastic
    gravtastic
	has_secure_password

	acts_as_voter

	def to_param
		username
	end

	has_many :links, dependent: :destroy

	validates :username, presence: true,
	                     uniqueness: {case_sensitive: false},
	                     length: {in: 4..12},
	                     format: {with: /\A[a-zA-Z][a-zA-Z0-9_-]*\Z/}
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true,
	                  uniqueness: {case_sensitive: false},
	                  email: true
	validates :password, presence: true,
	                     length: {minimum: 6} 

end
