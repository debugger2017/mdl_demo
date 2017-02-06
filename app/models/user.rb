class User < ApplicationRecord
	validates :name, presence: true, length: {maximum: 50}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence:true, length: {maximum:255},format: {with: VALID_EMAIL_REGEX},
									uniqueness: {case_sensitive: false}

	validates :password, presence: true, length: { minimum: 6 }	

	has_secure_password

	has_many :memberships , dependent: :destroy
	has_many :groups , :through => :memberships, dependent: :destroy
	has_many :invites , :class_name => 'Invitation' , :foreign_key => 'sender_id' , dependent: :destroy
	has_many :invitations , :class_name => 'Invitation' , :foreign_key => 'receiver_id' , dependent: :destroy
	has_many :requests , :foreign_key => 'sender_id' , dependent: :destroy
	has_many :comments , dependent: :destroy

	def User.digest(string)
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    	BCrypt::Password.create(string, cost: cost)
  	end

end
