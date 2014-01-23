require 'spec_helper'

describe "UserPages" do
  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:profile_attributes) { FactoryGirl.attributes_for(:profile, user: user) }
  let(:profile_attributes2) { FactoryGirl.attributes_for(:profile, user: user2) }

  subject { page }

  before do
    user.profile.update_attributes(profile_attributes)
    user.reload
    user2.profile.update_attributes(profile_attributes2)
    user2.reload
  end

  describe "profile page" do
    before { visit user_path(user) }
    
    it { should have_content('Stories Created') }
    it { should have_content('Stories Contributed To') }

    it { should have_content(user.profile.pen_name) }
    it { should have_title(user.profile.pen_name) }
    it { should_not have_content(user.username) }
    
    context "logged out" do
      it { should_not have_content(user.username) }
      it { should_not have_content(user.email) }
      it { should_not have_link('Edit Profile') }
      it { should_not have_link('Edit Login Information') }

      describe "visiting the profile edit page" do
        before { visit edit_user_profile_path(user) }

        it { should have_content('Login') }
      end
    end

    context "logged in" do
      before do
        login user
      end

      describe "visiting user's own profile" do
        before { visit user_path(user) }

        it { should have_content(user.username) }
        it { should have_content(user.email) }
        it { should have_link('Edit Profile') }
        it { should have_link('Edit Login Information') }

        describe "editing user's own profile" do
          before { click_link 'Edit Profile' }

          it { should have_content('Edit Profile') }

          describe "with invalid information" do
            before do
              fill_in 'Pen name', with: ''
              click_button 'Update Profile'
            end

            it { should have_selector('div#error_explanation') }
          end
        end
      end

      describe "visit another user's profile" do
        before { visit user_path(user2) }

        it { should_not have_content(user2.username) }
        it { should_not have_content(user2.email) }
        it { should_not have_link('Edit Profile') }
        it { should_not have_link('Edit Login Information') }
      end
    end
  end
end
