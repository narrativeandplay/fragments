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

require 'spec_helper'

describe Fragment do
  let(:user) { FactoryGirl.create(:user) }
  let(:story) { FactoryGirl.create(:story) }
  
  before do
    @fragment = FactoryGirl.create(:fragment, author: user, story: story)
  end
  
  subject { @fragment }
  
  it { is_expected.to respond_to(:content) }
  it { is_expected.to respond_to :intensity}
  
  it { is_expected.to respond_to(:author) }
  it { is_expected.to respond_to(:story) }
  it { is_expected.to respond_to(:parent) }
  
  describe '#author' do
    subject { super().author }
    it { is_expected.to eq user }
  end

  describe '#story' do
    subject { super().story }
    it { is_expected.to eq story }
  end
  
  it { is_expected.to be_valid }

  describe "blank content" do
    before { @fragment.content = "   " }
    
    it { is_expected.not_to be_valid }
  end

  describe "when author_id is nil" do
    before { @fragment.author_id = nil }
    
    it { is_expected.not_to be_valid }
  end

  describe "when story_id is nil" do
    before { @fragment.story_id = nil }
    
    it { is_expected.not_to be_valid }
  end

  describe "when intensity is nil" do
    before { @fragment.intensity = nil }

    it { is_expected.not_to be_valid }
  end

  describe "when intensity is negative" do
    before { @fragment.intensity = -1 }

    it { is_expected.not_to be_valid }
  end

  describe "when intensity is floating point number" do
    before { @fragment.intensity = 1.2 }

    it { is_expected.not_to be_valid }
  end
end
