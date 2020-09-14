class AddColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :image_link, :string
  end
end
