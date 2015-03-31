# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  text       :text
#  user_id    :integer
#  story_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :story

  default_scope -> { order(created_at: :desc) }

  validates :user, presence: true
  validates :story, presence: true
  validates :text, presence: true
end
