class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :text
      t.integer :post_id
      t.integer :user_id

      t.timestamps
    end
  add_index :comments, [:user_id, :created_at]
  end
end
