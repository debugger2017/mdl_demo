class CreateInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :invitations do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :group_id
      t.boolean :is_accepted
      t.timestamps
    end
    add_foreign_key :invitations , :users , column: :sender_id
  	add_foreign_key :invitations , :users , column: :receiver_id
  	add_foreign_key :invitations , :groups
  end
end
