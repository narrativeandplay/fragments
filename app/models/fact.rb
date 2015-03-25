class Fact < ActiveRecord::Base
  include Introspection

  belongs_to :fragment, inverse_of: :facts

  validates :text, presence: true, length: { maximum: 255 }
  validates :fragment, presence: true
end
