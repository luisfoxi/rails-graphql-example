# == Schema Information
#
# Table name: replies
#
#  id         :bigint           not null, primary key
#  body       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  comment_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_replies_on_comment_id  (comment_id)
#  index_replies_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (comment_id => comments.id)
#  fk_rails_...  (user_id => users.id)
#
class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  validates :body, presence: true
  validates :user_id, presence: true
  validates :comment_id, presence: true
end
