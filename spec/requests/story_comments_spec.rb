require 'spec_helper'

RSpec.describe "StoryComments", type: :request do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:story) { FactoryGirl.create(:story, creator: user) }
  let!(:fragment) { FactoryGirl.create(:fragment, story: story, author: user) }

  before do
    visit story_path story
  end

  subject { page }

  describe "story comments", js: true do
    it { is_expected.to have_selector("div#show-comment") }
    it { find('#show-comment').click; is_expected.to have_content('Comments')}

    context "logged in" do
      before do
        login user
      end

      it { find('#show-comment').click; is_expected.to have_content 'Leave a comment' }

      describe "creating a valid comment" do
        it "shows the comment" do
          find('#show-comment').click
          find(:xpath, "//form/textarea").set "Lorem Ipsum"
          click_button 'Comment'
          is_expected.to have_content "Lorem Ipsum"
        end
      end

      describe "creating an invalid comment" do
        it "shows an error" do
          find('#show-comment').click
          click_button "Comment"
          is_expected.to have_selector 'div#error_explanation'
        end
      end
    end

    context "logged out" do
      it { find('#show-comment').click; is_expected.not_to have_content 'Leave a comment' }
    end
  end
end
