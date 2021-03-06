class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :story

  default_scope -> { order(created_at: :desc) }

  validates :user, presence: true
  validates :story, presence: true
  validates :text, presence: true
end
