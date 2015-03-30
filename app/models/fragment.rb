# == Schema Information
#
# Table name: fragments
#
#  id         :integer          not null, primary key
#  content    :text
#  author_id  :integer
#  story_id   :integer
#  ancestry   :text
#  created_at :datetime
#  updated_at :datetime
#  intensity  :integer
#

class Fragment < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  belongs_to :story, inverse_of: :fragments
  
  has_ancestry
  
  validates :content, presence: true
  validates :author, presence: true
  validates :story, presence: true
end
