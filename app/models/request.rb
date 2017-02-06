class Request < ApplicationRecord
	belongs_to :group
	belongs_to :user , :foreign_key => 'sender_id' 
end
