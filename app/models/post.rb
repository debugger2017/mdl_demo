class Post < ApplicationRecord
	belongs_to :membership
	has_many :comments , dependent: :destroy

	validates :content , presence: true , length: { maximum: 255 }
end
