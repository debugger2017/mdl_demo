class Membership < ApplicationRecord
	belongs_to :user
	belongs_to :group
	has_many :posts , dependent: :destroy
end
