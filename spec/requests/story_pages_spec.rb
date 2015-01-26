require 'spec_helper'

shared_examples_for 'the new story form' do
  it { is_expected.to have_content 'Title' }
  it { is_expected.to have_content 'Content' }
  it { is_expected.to have_field 'Title' }
  it { is_expected.to have_field 'Content' }
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
    before { visit stories_path }

    it { is_expected.to have_link("New Story") }

    context "with one story" do
      it { is_expected.to have_content(story.title) }
      it { is_expected.to have_link(user.profile.pen_name, href: user_path(user)) }
      it { is_expected.to have_content("Contributors: #{story.authors.count}") }
      it { is_expected.to have_content("Created on: #{story.created_at.to_date}") }
      it { is_expected.to have_content("Last updated: #{story.updated_at.to_date}") }
    end

    context "with more than one story" do
      let!(:story1) { FactoryGirl.create(:story, creator: user) }
      let!(:fragment1) { FactoryGirl.create(:fragment, story: story1, author: user) }

      before { visit stories_path }

      it { is_expected.to have_content(story.title) }
      it { is_expected.to have_content(story1.title) }
      it { is_expected.to have_selector('hr') }
    end

    describe "clicking new story link" do
      context "logged in" do
        before do
          login user
          visit stories_path
          click_link 'New Story'
        end
        
        it_behaves_like 'the new story form'
      end

      context "logged out" do
        before { click_link 'New Story' }
        
        it { is_expected.to have_link("Register") }
        it { is_expected.to have_link("Login") }
      end
    end
  end

  describe "new story form" do
    context "logged in" do
      before do
        login user
        
        visit new_story_path
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
            is_expected.to have_selector('h2', text: 'Story')
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
                it { is_expected.to have_selector('div#error_explanation') }
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
                it { is_expected.to have_selector('div#error_explanation') }
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
                it { is_expected.to have_selector('div#error_explanation') }
              end
            end
          end
        end
      end
    end

    context "logged out" do
      before { visit new_story_path }
      
      it { is_expected.to have_selector('h2', text: 'Login') }
      it { is_expected.to have_field('Username') }
      it { is_expected.to have_field('Password') }
    end
  end

  describe "viewing a story", js: true do
    before { visit story_path(story) }
    
    it { is_expected.to have_selector('h2', story.title) }
    it 'has the story tree' do
      is_expected.to have_selector('svg', count: story.fragments.count)
    end

    describe "viewing a fragment's content", js: true do
      before do
        find('.circle').click
      end
      
      it { is_expected.to have_content(fragment.content) }
      it { is_expected.to have_link 'Read as prose' }
      it { is_expected.to have_link 'Continue story from here' } 
    end

    describe "adding a new fragment" do
      context "logged in" do
        before do
          login user
          visit story_path(story)
          find('.circle').click
          click_link('Continue story from here')
        end

        it { is_expected.to have_content 'Content' }
        it { is_expected.to have_content 'Author' }
        it { is_expected.to have_content user.profile.pen_name }
        it { is_expected.not_to have_selector('div#error_explanation') }

        describe "with invalid content" do          
          it { click_button "Create Fragment"; is_expected.to have_selector('div#error_explanation') }
          it 'does not create a new fragment' do
            expect { click_button "Create Fragment" }.to_not change(Fragment, :count)
          end
        end

        describe "with valid content" do
          before do
            fill_in_ckeditor 'fragment_content', with: 'Lorem Lorem Ipsum'
          end
          
          it 'creates a new fragment' do
            click_button "Create Fragment"
            expect(all('.circle').count).to eq 2
            all('.circle')[1].click
            is_expected.to have_content('Lorem Lorem Ipsum')
          end
          it "redirects to the fragment's story page" do
            click_button "Create Fragment"
            is_expected.to have_content story.title
          end
        end
      end

      context "logged out" do
        before do
          find('.circle').click
          click_link('Continue story from here')
        end

        it { is_expected.not_to have_content 'Content' }
        it { is_expected.to have_link('Register') }
        it { is_expected.to have_link('Login') }
      end
    end

    describe "editing a fragment" do
      context "logged in" do
        context "as fragment author" do
          before do 
            login user
            visit story_path(story)
            find('.circle').click
          end
          
          it { is_expected.to have_link('Edit this fragment') }

          describe "editing the fragment" do
            before { click_link 'Edit this fragment' }

            it { is_expected.to have_content 'Content' }
            it { is_expected.to have_content 'Author' }
            it { is_expected.to have_content user.profile.pen_name }
            it { is_expected.not_to have_selector('div#error_explanation') }

            describe "with valid content" do
              before do
                fill_in_ckeditor 'edit_form', with: 'Lore'
              end
              
              it "redirects to the fragment's story" do
                click_button 'Update Fragment'
                is_expected.to have_content fragment.story.title
              end
              it "updates the fragment" do
                click_button 'Update Fragment'
                find('.circle').click
                is_expected.to have_content('Lore')
              end
            end

            describe "with invalid content" do
              before do
                fill_in_ckeditor 'edit_form', with: '  '
              end
              
              it { click_button 'Update Fragment'; is_expected.to have_selector('div#error_explanation') }
              it 'does not update the fragment' do
                click_button 'Update Fragment'
                visit story_path(story)
                find('.circle').click
                is_expected.to have_content('Lorem Ipsum')
              end
            end
          end
        end

        context "as another user" do
          let(:user2) { FactoryGirl.create(:user) }
          before do
            login user2
            visit story_path(story)
            find('.circle').click
          end
          
          it { is_expected.not_to have_link('Edit this fragment') }
        end
      end

      context "logged out" do
        before do
          find('.circle').click
        end

        it { is_expected.not_to have_link('Edit this fragment') }
      end
    end
  end
end
