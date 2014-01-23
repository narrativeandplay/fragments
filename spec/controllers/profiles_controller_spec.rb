require 'spec_helper'

describe ProfilesController do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:profile_attributes) { FactoryGirl.attributes_for(:profile, user: user) }
  
  describe "GET 'edit'" do
    context "logged in" do
      before do
        login(user, false)
        get :edit, user_id: user
      end

      it "returns http success" do
        response.should be_success
      end

      it 'renders the edit form' do
        response.should render_template :edit
      end
    end

    context "logged out" do
      before { get :edit, user_id: user }

      it "returns http failure" do
        response.should_not be_success
      end

      it 'does not render the edit form' do
        response.should_not render_template :edit
      end
    end
  end

  describe "POST #update" do
    context "logged out" do
      before { post :update, user_id: user, profile: profile_attributes }

      it "does not update the profile" do
        user.profile.pen_name.should_not eq profile_attributes[:pen_name]
      end

      it 'redirects to the login form' do
        response.should redirect_to new_user_session_path
      end
    end

    context "logged in" do
      before do
        login(user, false)
        post :update, user_id: user, profile: profile_attributes
      end

      it "updates the profile" do
        user.profile.reload
        user.profile.pen_name.should eq profile_attributes[:pen_name]
        user.profile.description.should eq profile_attributes[:description]
      end

      it 'redirects to the user profile' do
        response.should redirect_to user_path(user)
      end
    end
  end

end
