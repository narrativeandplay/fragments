require 'spec_helper'

describe FragmentsController do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:story) { FactoryGirl.create(:story, creator: user) }
  let!(:fragment) { FactoryGirl.create(:fragment, story: story, author: user) }
  
  before do
    sign_in user
    request.env["HTTP_ACCEPT"] = 'application/json'
  end
  
  describe "GET #show" do
    before do
      get :show, story_id: fragment.story, id: fragment
    end
    
    it 'assigns the requested fragment to @fragment' do
      assigns(:fragment).should eq fragment
    end
    
    it 'returns a JSON object of the fragment' do
      response.body.should eq fragment.to_json
    end
  end

  describe "POST #create" do
    let(:fragment_attributes) { FactoryGirl.attributes_for(:fragment, story: story, parent: fragment, author: user) }

    context "with valid attributes" do
      it 'creates a new fragment' do
        expect {
          post :create, story_id: story, fragment: fragment_attributes
        }.to change(Fragment, :count).by(1)
      end
      
      it 'redirects to the story the fragment is created for' do
        post :create, story_id: story, fragment: fragment_attributes
        Rails.logger.debug response.body.inspect
        response.body.should include 'window.location'
      end
    end

    context "with invalid attributes" do
      before { fragment_attributes[:content] = '   ' }
      
      it 'does not save the new fragment' do
        expect {
          post :create, story_id: fragment.story, fragment: fragment_attributes
        }.not_to change(Fragment, :count)
      end
    end
  end
end
