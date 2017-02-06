class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.integer :sender_id
      t.integer :group_id
      t.boolean :is_granted
      t.timestamps
    end
    add_foreign_key :requests , :groups , column: :group_id
    add_foreign_key :requests , :users , column: :sender_id
  end
end
