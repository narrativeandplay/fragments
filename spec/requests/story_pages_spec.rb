require 'spec_helper'

share_examples_for 'the new story form' do
  it { should have_content 'Title' }
  it { should have_content 'Content' }
  it { should have_field 'Title' }
  it { should have_field 'Content' }
end

describe "StoryPages" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:story) { FactoryGirl.create(:story, creator: user) }
  let!(:fragment) { FactoryGirl.create(:fragment, story: story, author: user) }
  
  before do
    visit root_path
  end
  
  subject { page }
  
  describe "stories index" do
    before { visit stories_url }

    it { should have_link("New Story") }

    context "with one story" do
      it { should have_content(story.title)}
    end

    context "with more than one story" do
      let!(:story1) { FactoryGirl.create(:story, creator: user) }
      let!(:fragment1) { FactoryGirl.create(:fragment, story: story1, author: user) }

      before { visit stories_url }

      it { should have_content(story.title) }
      it { should have_content(story1.title) }
      it { should have_selector('hr') }
    end

    describe "clicking new story link" do
      context "logged in" do
        before do
          login user
          visit stories_url
          click_link 'New Story'
        end
        
        it_behaves_like 'the new story form'
      end

      context "logged out" do
        before { click_link 'New Story' }
        
        it { should have_link("Register") }
        it { should have_link("Login") }
      end
    end
  end

  describe "new story form" do
    context "logged in" do
      before do
        login user
        
        visit new_story_url
      end
      
      it_behaves_like 'the new story form'

      describe "creating a new story" do
        context 'with valid attributes' do
          before do
            fill_in 'Title', with: "Story"
            fill_in 'Content', with: "Lorem Ipsum"
          end
          
          it 'creates a new story' do
            expect { click_button 'Create Story' }.to change(Story, :count).by(1)
          end
          it 'redirects to the story page' do
            click_button 'Create Story'
            should have_selector('h2', text: 'Story')
          end
        end

        context 'with invalid attributes' do
          context "with invalid title" do
            describe "blank title" do
              before do
                fill_in 'Title', with: "  "
                fill_in 'Content', with: "Lorem Ipsum"
              end

              it 'does not create a new story' do
                expect { click_button 'Create Story' }.to_not change(Story, :count)
              end
              describe "re-rendering the new form" do
                before { click_button 'Create Story' }
                
                it_behaves_like 'the new story form'
                it { should have_selector('div#error_explanation') }
              end
            end

            describe "title too short" do
              before do
                fill_in 'Title', with: "a"
                fill_in 'Content', with: "Lorem Ipsum"
              end

              it 'does not create a new story' do
                expect { click_button 'Create Story' }.to_not change(Story, :count)
              end
              describe "re-rendering the new form" do
                before { click_button 'Create Story' }

                it_behaves_like 'the new story form'
                it { should have_selector('div#error_explanation') }
              end
            end
          end

          context "invalid content" do
            describe "blank content" do
              before do
                fill_in 'Title', with: "Title"
                fill_in 'Content', with: "   "
              end

              it 'does not create a new story' do
                expect { click_button 'Create Story' }.to_not change(Story, :count)
              end
              describe "re-rendering the new form" do
                before { click_button 'Create Story' }

                it_behaves_like 'the new story form'
                it { should have_selector('div#error_explanation') }
              end
            end
          end
        end
      end
    end

    context "logged out" do
      before { visit new_story_url }
      
      it { should have_selector('h2', text: 'Login') }
      it { should have_field('Username') }
      it { should have_field('Password') }
    end
  end

  describe "viewing a story" do
    before { visit story_url(story) }
    
    it { should have_selector('h2', story.title) }
  end
end
