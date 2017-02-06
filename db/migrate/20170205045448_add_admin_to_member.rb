class AddAdminToMember < ActiveRecord::Migration[5.0]
  def change
  	add_column :memberships , :is_admin , :boolean
  end
end
