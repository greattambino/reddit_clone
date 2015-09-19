# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text             not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Foreign Keys
#
#  fk_rails_5b5ddfd518  (user_id => users.id)
#

class Post < ActiveRecord::Base
  validates :title, :content, :user_id, presence: true
  validates :sub_ids, length: {minimum: 1}

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many :post_subs
  has_many :subs, through: :post_subs
end
