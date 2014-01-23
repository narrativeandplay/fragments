require 'spec_helper'

describe Profile do
  let(:user) { FactoryGirl.create(:user) }
  
  before do
    @profile = FactoryGirl.create(:profile, user: user)
  end
  
  subject { @profile }
  
  it { should respond_to(:pen_name) }
  it { should respond_to(:description) }
  
  it { should respond_to(:user) }
  
  its(:user) { should eq user}
  
  it { should be_valid }

  describe "when user_id is nil" do
    before { @profile.user_id = nil }
    
    it { should_not be_valid }
  end

  describe "when pen name is blank" do
    before { @profile.pen_name = "  " }
    
    it { should_not be_valid }
  end
end
