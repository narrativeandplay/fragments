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
    
    it { is_expected.to have_content('Stories Created') }
    it { is_expected.to have_content('Stories Contributed To') }

    it { is_expected.to have_content(user.profile.pen_name) }
    it { is_expected.to have_title(user.profile.pen_name) }
    it { is_expected.not_to have_content(user.username) }
    
    context "logged out" do
      it { is_expected.not_to have_content(user.username) }
      it { is_expected.not_to have_content(user.email) }
      it { is_expected.not_to have_link('Edit Profile') }
      it { is_expected.not_to have_link('Edit Login Information') }

      describe "visiting the profile edit page" do
        before { visit edit_user_profile_path(user) }

        it { is_expected.to have_content('Login') }
      end
    end

    context "logged in" do
      before do
        login user
      end

      describe "visiting user's own profile" do
        before { visit user_path(user) }

        it { is_expected.to have_content(user.username) }
        it { is_expected.to have_content(user.email) }
        it { is_expected.to have_link('Edit Profile') }
        it { is_expected.to have_link('Edit Login Information') }

        describe "editing user's own profile" do
          before { click_link 'Edit Profile' }

          it { is_expected.to have_content('Edit Profile') }

          describe "with invalid information" do
            before do
              fill_in 'Pen name', with: ''
              click_button 'Update Profile'
            end

            it { is_expected.to have_selector('div#error_explanation') }
          end
        end
      end

      describe "visit another user's profile" do
        before { visit user_path(user2) }

        it { is_expected.not_to have_content(user2.username) }
        it { is_expected.not_to have_content(user2.email) }
        it { is_expected.not_to have_link('Edit Profile') }
        it { is_expected.not_to have_link('Edit Login Information') }
      end
    end
  end
end
