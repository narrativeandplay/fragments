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
#

class Fragment < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  belongs_to :story, inverse_of: :fragments
  
  has_ancestry
  
  validates :content, presence: true
  validates :author, presence: true
  validates :story, presence: true
  validates :intensity, presence: true, numericality: { only_integer: true,
                                                        greater_than_or_equal_to: 0,
                                                        less_than_or_equal_to: 10 }
end
