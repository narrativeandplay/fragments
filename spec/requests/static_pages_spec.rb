require 'spec_helper'

describe "Static Pages" do
  subject { page }

  describe "home page" do
    before { visit root_path }

    it { is_expected.to have_content('Fragments') }
    it { is_expected.to have_title('Fragments') }
    it { is_expected.not_to have_title('| Home') }
  end

  describe "help page" do
    before { visit help_path }

    it { is_expected.to have_content('Help') }
    it { is_expected.to have_title('Fragments | Help') }
  end

  describe "about page" do
    before { visit about_path }

    it { is_expected.to have_content('About') }
    it { is_expected.to have_title('Fragments | About') }
  end

  describe "contact page" do
    before { visit contact_path }

    it { is_expected.to have_content('Contact Us') }
    it { is_expected.to have_title('Fragments | Contact Us') }
  end
end
