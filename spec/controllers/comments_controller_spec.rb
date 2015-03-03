require 'spec_helper'

RSpec.describe CommentsController, type: :controller do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:story) { FactoryGirl.create(:story, creator: user) }

  describe "POST #create" do
    let(:comment_attributes) { FactoryGirl.attributes_for(:comment, user: user, story: story) }

    describe "when logged in" do
      before { sign_in user }

      context "with blank comment" do
        before { comment_attributes[:text] = '    ' }

        it "does not create a new comment" do
          expect {
            post :create, story_id: story, comment: comment_attributes, format: :js
          }.to_not change(Comment, :count)
        end
      end

      context "with valid comment" do
        it "creates a new comment" do
          expect {
            post :create, story_id: story, comment: comment_attributes, format: :js
          }.to change(Comment, :count).by(1)
        end
      end
    end

    describe "when not logged in" do
      it "does not save the new comment" do
        expect {
          post :create, story_id: story, comment: comment_attributes, format: :js
        }.to_not change(Comment, :count)
      end

      it 'redirects to the login page' do
        post :create, story_id: story, comment: comment_attributes, format: :js
        expect(response.body).to include "window.location = '#{new_user_session_url}'"
      end
    end
  end

end
