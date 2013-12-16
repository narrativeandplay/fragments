class Story < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
  
  has_many :fragments
  
  validates :title, presence: true, length: { minimum: 2 }
  validates :creator_id, presence: true
end
