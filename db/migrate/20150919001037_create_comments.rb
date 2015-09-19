class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.integer :user_id, null: false
      t.integer :post_id, null: false
      t.integer :parent_id
      t.timestamps null: false
    end
    add_index :comments, :user_id
    add_index :comments, :post_id
    add_index :comments, :parent_id
    add_foreign_key :comments, :users
    add_foreign_key :comments, :posts
  end
end
