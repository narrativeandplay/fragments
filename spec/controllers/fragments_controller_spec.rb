require 'spec_helper'

describe FragmentsController do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:story) { FactoryGirl.create(:story, creator: user) }
  let!(:fragment) { FactoryGirl.create(:fragment, story: story, author: user) }
  
  describe "GET #show" do
    before do
      xhr :get, :show, story_id: fragment.story, id: fragment, format: 'js'
    end
    
    it 'assigns the requested fragment to @fragment' do
      expect(assigns(:fragment)).to eq fragment
    end
    
    it "assigns the fragment's story to @story" do
      expect(assigns(:story)).to eq story
    end
  end

  describe "POST #create" do
    let(:fragment_attributes) { FactoryGirl.attributes_for(:fragment, story: story, parent: fragment.id, author: user) }

    context "when logged in" do
      before { sign_in user }
      
      context "with valid attributes" do
        it 'creates a new fragment' do
          expect {
            post :create, story_id: story, fragment: fragment_attributes
          }.to change(Fragment, :count).by(1)
        end

        it 'redirects to the story the fragment is created for' do
          post :create, story_id: story, fragment: fragment_attributes
          expect(response.body).to include "window.location = '#{story_url story}'"
        end
      end

      context "with invalid attributes" do
        before { fragment_attributes[:content] = '   ' }

        it 'does not save the new fragment' do
          expect {
            post :create, story_id: fragment.story, fragment: fragment_attributes, format: :js
          }.not_to change(Fragment, :count)
        end
      end
    end

    describe "when not logged in" do
      it 'does not save the new fragment' do
        expect {
          post :create, story_id: fragment.story, fragment: fragment_attributes
        }.not_to change(Fragment, :count)
      end
      
      it 'redirects to the login page' do
        post :create, story_id: story, fragment: fragment_attributes
        expect(response.body).to include "window.location = '#{new_user_session_url}'"
      end
    end
  end

  describe "PATCH #update" do
    let(:fragment_attributes) { fragment.attributes }
    
    before { fragment_attributes["content"] = "Lore" }
    
    context "when logged in" do
      context "as fragment's author" do
        before { sign_in user }

        context "with valid attributes" do
          it 'updates the fragment' do
            expect {
              patch :update, story_id: story, id: fragment_attributes["id"], fragment: fragment_attributes
              fragment.reload
            }.to change(fragment, "content")
          end

          it 'redirects to the story of the fragment' do
            patch :update, story_id: story, id: fragment_attributes["id"], fragment: fragment_attributes
            expect(response.body).to include "window.location = '#{story_url story}'"
          end
        end

        context "with invalid attributes" do
          before { fragment_attributes["content"] = '    ' }

          it 'does not update the fragment' do
            expect {
              patch :update, story_id: story, id: fragment_attributes["id"], fragment: fragment_attributes, format: 'js'
              fragment.reload
            }.not_to change(fragment, 'content')
          end
        end
      end

      context "as another user" do
        let(:user2) { FactoryGirl.create(:user) }
        before { sign_in user2 }

        it 'does not update the fragment' do
          expect {
            patch :update, story_id: story, id: fragment_attributes["id"], fragment: fragment_attributes, format: 'js'
            fragment.reload
          }.not_to change(fragment, 'content')
        end
      end
    end

    context "when not logged in" do
      it 'does not update the fragment' do
        expect {
          patch :update, story_id: story, id: fragment_attributes["id"], fragment: fragment_attributes
        }.not_to change(fragment, "content")
      end
      
      it 'redirects to the login page' do
        patch :update, story_id: story, id: fragment_attributes["id"], fragment: fragment_attributes
        expect(response.body).to include "window.location = '#{new_user_session_url}'"
      end
    end
  end
end
