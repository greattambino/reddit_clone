# == Schema Information
#
# Table name: subs
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  title       :string           not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Foreign Keys
#
#  fk_rails_67f5376a4c  (user_id => users.id)
#

class Sub < ActiveRecord::Base
  validates :user_id, :title, presence: true

  belongs_to(
    :moderator,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many :post_subs
  has_many :posts, through: :post_subs

end
