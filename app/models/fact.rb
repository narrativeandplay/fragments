class Fact < ActiveRecord::Base
  belongs_to :fragment

  validates :text, presence: true, length: { maximum: 255 }
  validates :fragment, presence: true
end
