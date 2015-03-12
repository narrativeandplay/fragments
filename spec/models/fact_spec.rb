require 'spec_helper'

RSpec.describe Fact, type: :model do
  let(:fragment) { FactoryGirl.create(:fragment) }

  before do
    @fact = FactoryGirl.create :fact, fragment: fragment
  end

  subject { @fact }

  it { is_expected.to respond_to :text }
  it { is_expected.to respond_to :fragment }

  describe "#fragment" do
    subject { @fact.fragment }

    it { is_expected.to eq fragment }
  end

  describe "when text is blank" do
    before { @fact.text = '   ' }

    it { is_expected.not_to be_valid }
  end

  describe "when text is too long" do
    before { @fact.text = 'a'*256 }

    it { is_expected.not_to be_valid }
  end

  describe "when fragment_id is nil" do
    before { @fact.fragment_id = nil }

    it { is_expected.not_to be_valid }
  end
end
