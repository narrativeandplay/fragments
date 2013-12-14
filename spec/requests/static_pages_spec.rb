require 'spec_helper'

describe "Static Pages" do
  subject { page }

  describe "home page" do
    before { visit root_path }

    it { should have_content('Fragments') }
    it { should have_title('Fragments') }
    it { should_not have_title('| Home') }
  end

  describe "help page" do
    before { visit help_path }

    it { should have_content('Help') }
    it { should have_title('Fragments | Help') }
  end

  describe "about page" do
    before { visit about_path }

    it { should have_content('About') }
    it { should have_title('Fragments | About') }
  end

  describe "contact page" do
    before { visit contact_path }

    it { should have_content('Contact Us') }
    it { should have_title('Fragments | Contact Us') }
  end
end
