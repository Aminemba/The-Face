class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
  t.references :likeable, polymorphic: true, null: false
  t.integer :user_id
  t.timestamps
    end
    add_index :likes, :user_id
    add_index :likes, :likeable_type
    add_index :likes, :likeable_id
  end
end
