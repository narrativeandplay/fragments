# == Schema Information
#
# Table name: stories
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  creator_id :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Story do
  let(:user) { FactoryGirl.create(:user) }
  before do
    @story = FactoryGirl.create(:story, creator: user)
  end
  
  subject { @story }
  
  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:creator) }
  
  it { is_expected.to respond_to(:fragments) }
  it { is_expected.to respond_to(:authors) }
  
  describe '#creator' do
    subject { super().creator }
    it { is_expected.to eq user }
  end
  
  it { is_expected.to be_valid }

  describe "invalid titles" do
    context "blank title" do
      before { @story.title = "    " }
      
      it { is_expected.not_to be_valid }
    end

    context "title too short" do
      before { @story.title = '1' }
      
      it { is_expected.not_to be_valid }
    end
  end

  describe "blank creator id" do
    before { @story.creator_id = nil }
    
    it { is_expected.not_to be_valid }
  end
end
