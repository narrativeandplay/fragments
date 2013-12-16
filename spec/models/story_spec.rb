require 'spec_helper'

describe Story do
  let(:user) { FactoryGirl.create(:user) }
  before do
    @story = FactoryGirl.create(:story, creator: user)
  end
  
  subject { @story }
  
  it { should respond_to(:title) }
  it { should respond_to(:creator) }
  
  
  its(:creator) { should eq user }
  
  it { should be_valid }

  describe "invalid titles" do
    context "blank title" do
      before { @story.title = "    " }
      
      it { should_not be_valid }
    end

    context "title too short" do
      before { @story.title = '1' }
      
      it { should_not be_valid }
    end
  end

  describe "blank creator id" do
    before { @story.creator_id = nil }
    
    it { should_not be_valid }
  end
end
