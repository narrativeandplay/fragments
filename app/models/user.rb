# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  username               :string(255)      default(""), not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable, :trackable, 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :stories, foreign_key: :creator_id
  has_many :fragments, foreign_key: :author_id
  
  has_one :profile, inverse_of: :user
  
  validates :username, presence: true, length: { minimum: 2 }, uniqueness: { case_sensitive: false }

  before_validation :clear_whitespace
  before_save :make_profile
  
  def stories_contributed_to
    Story.where(id: self.fragments.pluck(:story_id).uniq)
  end

  private
  # Allow login using case insensitive username, but save case senstive username in DB
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if username = conditions.delete(:username)
      where(conditions).where(["lower(username) = :value", { :value => username.downcase }]).first
    else
      where(conditions).first
    end
  end
  
  def clear_whitespace
    self.username.delete!(' ')
  end
  
  def make_profile
    if self.profile.nil?
      self.create_profile
      self.profile.pen_name = self.username
    end
  end
end
