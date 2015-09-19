# == Schema Information
#
# Table name: post_subs
#
#  id         :integer          not null, primary key
#  sub_id     :integer          not null
#  post_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Foreign Keys
#
#  fk_rails_65b82c2354  (post_id => posts.id)
#  fk_rails_b90e08fbd0  (sub_id => subs.id)
#

class PostSub < ActiveRecord::Base
  validates :sub, :post, presence: true

  belongs_to :post
  belongs_to :sub
end
