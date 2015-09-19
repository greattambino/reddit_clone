class AddForeignKeys < ActiveRecord::Migration
  def change
    add_foreign_key :subs, :users
    add_foreign_key :post_subs, :subs
    add_foreign_key :post_subs, :posts
    add_foreign_key :posts, :users
  end
end
