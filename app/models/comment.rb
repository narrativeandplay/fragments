class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :story

  validates :user, presence: true
  validates :story, presence: true
  validates :text, presence: true
end
