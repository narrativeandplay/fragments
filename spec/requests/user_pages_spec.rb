require 'spec_helper'

describe "UserPages" do
  let(:user) { FactoryGirl.create(:user) }
  subject { page }

  describe "profile page" do
    before { visit user_path(user) }
    
    it { should have_content(user.username) }
    it { should have_title(user.username) }
  end
end
