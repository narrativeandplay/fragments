require 'spec_helper'

describe "UserPages" do
  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  subject { page }

  describe "profile page" do
    before { visit user_path(user) }
    
    it { should have_content('Stories Created') }

    it { should have_content(user.username) }
    it { should have_title(user.username) }
    
    context "logged out" do
      it { should_not have_content(user.email) }
      it { should_not have_link('Edit Profile') }
    end

    context "logged in" do
      before do
        login user
      end

      describe "visiting user's own profile" do
        before { visit user_path(user) }

        it { should have_content(user.email) }
        it { should have_link('Edit Login Information') }
      end

      describe "visit another user's profile" do
        before { visit user_path(user2) }
        
        it { should_not have_link('Edit Profile') }
      end
    end
  end
end
