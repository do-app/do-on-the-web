

class User < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true 
	validates :password, presence: true, confirmation: true 
	validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
							confirmation: true, uniqueness: true
	
	
end
