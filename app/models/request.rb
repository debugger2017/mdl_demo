class Request < ApplicationRecord
	belongs_to :group
	belongs_to :user , :foreign_key => 'sender_id' 
	validates_uniqueness_of :sender_id, :scope => [:group_id]
end
