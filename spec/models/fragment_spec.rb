require 'spec_helper'

describe Fragment do
  let(:user) { FactoryGirl.create(:user) }
  let(:story) { FactoryGirl.create(:story) }
  
  before do
    @fragment = FactoryGirl.create(:fragment, author: user, story: story)
  end
  
  subject { @fragment }
  
  it { should respond_to(:content) }
  
  it { should respond_to(:author) }
  it { should respond_to(:story) }
  it { should respond_to(:parent) }
  
  its(:author) { should eq user }
  its(:story) { should eq story }
  
  it { should be_valid }

  describe "blank content" do
    before { @fragment.content = "   " }
    
    it { should_not be_valid }
  end

  describe "when author_id is nil" do
    before { @fragment.author_id = nil }
    
    it { should_not be_valid }
  end

  describe "when story_id is nil" do
    before { @fragment.story_id = nil }
    
    it { should_not be_valid }
  end
end
