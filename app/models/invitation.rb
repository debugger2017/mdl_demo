class Invitation < ApplicationRecord
	belongs_to :group
	has_one :sender, :class_name => 'User'
	has_one :receiver, :class_name => 'User'
	validates_uniqueness_of :sender_id, :scope => [:receiver_id,:group_id]
end
