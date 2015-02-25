require 'spec_helper'

describe StoriesController do
  let(:user) { FactoryGirl.create(:user) }
  let(:story) { FactoryGirl.create(:story, creator: user) }
  let!(:fragment) { FactoryGirl.create(:fragment, author:user, story: story) }
  let!(:other_fragment) { FactoryGirl.create(:fragment, author:user, story: story, parent: fragment) }
  
  describe "GET #index" do
    before { get :index}
    
    it 'populates an array of stories' do
      expect(assigns(:stories)).to eq [story]
    end
    
    it 'renders the index view' do
      expect(response).to render_template :index
    end
  end

  describe "GET #new" do
    context "when logged in" do
      before do
        sign_in user
        get :new
      end
      
      it 'assigns a new Story to @story' do
        expect(assigns(:story)).to be_a_new(Story)
        expect(assigns(:story)).not_to be_changed
      end

      it 'assigns a new Fragment to @fragment' do
        expect(assigns(:fragment)).to be_a_new(Fragment)
        expect(assigns(:fragment)).not_to be_changed
      end

      it 'renders the :new template' do
        expect(response).to render_template :new
      end
    end

    describe "when not logged in" do
      it 'redirects to the login page' do
        get :new
        expect(response).to redirect_to new_user_session_url
      end
    end
  end

  describe "GET #show" do
    before { get :show, id: story }
    
    it 'assigns the requested story to @story' do
      expect(assigns(:story)).to eq story
    end
    
    it "assigns a new Fragment to @fragments" do
      expect(assigns(:fragment)).to be_a_new(Fragment)
    end
    
    it 'renders the :show template' do
      expect(response).to render_template :show
    end
  end

  describe "POST #create" do
    let(:story_attributes) { FactoryGirl.attributes_for(:story) }
    let(:fragment_attributes) { FactoryGirl.attributes_for(:fragment, author: user, story: story_attributes) }

    context "logged in" do
      before { sign_in user }
      
      context "with valid attributes" do
        it 'creates a new story' do
          expect {
            post :create, story: story_attributes.merge(fragment: fragment_attributes)
          }.to change(Story, :count).by(1)
        end

        it 'creates a new fragment' do
          expect {
            post :create, story: story_attributes.merge(fragment: fragment_attributes)
          }.to change(Fragment, :count).by(1)
        end

        it 'redirects to the new story' do
          post :create, story: story_attributes.merge(fragment: fragment_attributes)
          expect(response).to redirect_to assigns(:story)
        end
      end

      context "with invalid attributes" do
        describe "blank title" do
          let(:story_attributes) { FactoryGirl.attributes_for(:story, title: '  ') }

          it 'does not save the new story' do
            expect {
              post :create, story: story_attributes.merge(fragment: fragment_attributes)
            }.not_to change(Story, :count)
          end

          it 'does not save the new fragment' do
            expect {
              post :create, story: story_attributes.merge(fragment: fragment_attributes)
            }.not_to change(Fragment, :count)
          end

          it 're-renders the new method' do
            post :create, story: story_attributes.merge(fragment: fragment_attributes)
            expect(response).to render_template :new
          end
        end

        describe "blank content" do
          let(:fragment_attributes) { FactoryGirl.attributes_for(:fragment, content: '  ') }

          it 'does not save the new story' do
            expect {
              post :create, story: story_attributes.merge(fragment: fragment_attributes)
            }.not_to change(Story, :count)
          end

          it 'does not save the new fragment' do
            expect {
              post :create, story: story_attributes.merge(fragment: fragment_attributes)
            }.not_to change(Fragment, :count)
          end

          it 're-renders the new method' do
            post :create, story: story_attributes.merge(fragment: fragment_attributes)
            expect(response).to render_template :new
          end
        end
      end
    end

    describe "when not logged in" do
      it 'does not save the new story' do
        expect {
          post :create, story: story_attributes.merge(fragment: fragment_attributes)
        }.not_to change(Story, :count)
      end

      it 'does not save the new fragment' do
        expect {
          post :create, story: story_attributes.merge(fragment: fragment_attributes)
        }.not_to change(Fragment, :count)
      end
      
      it 'redirects to the login page' do
        post :create, story: story_attributes.merge(fragment: fragment_attributes)
        expect(response).to redirect_to new_user_session_url
      end
    end
    
  end
end
