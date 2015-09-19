# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text             not null
#  user_id    :integer          not null
#  post_id    :integer          not null
#  parent_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Foreign Keys
#
#  fk_rails_03de2dc08c  (user_id => users.id)
#  fk_rails_2fd19c0db7  (post_id => posts.id)
#

class Comment < ActiveRecord::Base
  validates :content, :user_id, :post_id, presence: true

  belongs_to(
    :author,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id
  )

  belongs_to :post

  belongs_to(
    :parent,
    class_name: "Comment",
    primary_key: :id,
    foreign_key: :parent_id
  )

end
