# == Schema Information
#
# Table name: profiles
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  pen_name    :string
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Profile < ActiveRecord::Base
  belongs_to :user, inverse_of: :profile
  
  validates :pen_name, presence: true
  validates :user, presence: true
  
  before_save do
    self.description = nil if self.description.blank?
  end
end
