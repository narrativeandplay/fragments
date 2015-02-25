require 'spec_helper'

describe Profile do
  let(:user) { FactoryGirl.create(:user) }
  
  before do
    @profile = FactoryGirl.create(:profile, user: user)
  end
  
  subject { @profile }
  
  it { is_expected.to respond_to(:pen_name) }
  it { is_expected.to respond_to(:description) }
  
  it { is_expected.to respond_to(:user) }
  
  describe '#user' do
    subject { super().user }
    it { is_expected.to eq user}
  end
  
  it { is_expected.to be_valid }

  describe "when user_id is nil" do
    before { @profile.user_id = nil }
    
    it { is_expected.not_to be_valid }
  end

  describe "when pen name is blank" do
    before { @profile.pen_name = "  " }
    
    it { is_expected.not_to be_valid }
  end
end
