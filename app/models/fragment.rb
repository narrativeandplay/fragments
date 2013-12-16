class Fragment < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  belongs_to :story
  
  has_ancestry
  
  validates :content, presence: true
  validates :author_id, presence: true
  validates :story_id, presence: true
end
