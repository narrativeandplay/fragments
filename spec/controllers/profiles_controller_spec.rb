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
        expect(response).to be_success
      end

      it 'renders the edit form' do
        expect(response).to render_template :edit
      end
    end

    context "logged out" do
      before { get :edit, user_id: user }

      it "returns http failure" do
        expect(response).not_to be_success
      end

      it 'does not render the edit form' do
        expect(response).not_to render_template :edit
      end
    end
  end

  describe "POST #update" do
    context "logged out" do
      before { post :update, user_id: user, profile: profile_attributes }

      it "does not update the profile" do
        expect(user.profile.pen_name).not_to eq profile_attributes[:pen_name]
      end

      it 'redirects to the login form' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "logged in" do
      before do
        login(user, false)
        post :update, user_id: user, profile: profile_attributes
      end

      it "updates the profile" do
        user.profile.reload
        expect(user.profile.pen_name).to eq profile_attributes[:pen_name]
        expect(user.profile.description).to eq profile_attributes[:description]
      end

      it 'redirects to the user profile' do
        expect(response).to redirect_to user_path(user)
      end
    end
  end

end
