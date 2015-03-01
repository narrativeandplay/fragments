require 'spec_helper'

RSpec.describe Comment, :type => :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:story) { FactoryGirl.create(:story) }

  before do
    @comment = FactoryGirl.create :comment, user: user, story: story
  end

  subject { @comment }

  it { is_expected.to respond_to :text }

  it { is_expected.to respond_to :user }
  it { is_expected.to respond_to :story }

  describe "#user" do
    subject { @comment.user }

    it { is_expected.to eq user }
  end

  describe "#story" do
    subject { @comment.story }

    it { is_expected.to eq story }
  end

  describe "blank text" do
    before { @comment.text = "   " }

    it { is_expected.not_to be_valid }
  end

  describe "when user_id is nil" do
    before { @comment.user_id = nil }

    it { is_expected.not_to be_valid }
  end

  describe "when story_id is nil" do
    before { @comment.story_id = nil }

    it { is_expected.not_to be_valid }
  end
end
