class Group < ApplicationRecord
	has_many :memberships , dependent: :destroy
	has_many :users , :through => :memberships
	has_many :invitations , dependent: :destroy
	has_many :requests , dependent: :destroy

	validates :name , presence: true , uniqueness: {case_sensitive: false} , length: { maximum: 6 }	
end

