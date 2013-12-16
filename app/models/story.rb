class Story < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
  
  validates :title, presence: true, length: { minimum: 2 }
  validates :creator_id, presence: true
end
