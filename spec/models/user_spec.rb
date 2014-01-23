# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  username               :string(255)      default(""), not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

require 'spec_helper'

describe User do
  before do
    @user = FactoryGirl.create(:user)
  end

  subject { @user }

  it { should respond_to(:username) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  
  it { should respond_to(:profile) }
  
  it { should respond_to(:stories) }
  it { should respond_to(:fragments) }

  it { should be_valid }

  describe "when username is blank" do
    before { @user.username = "  " }

    it { should_not be_valid }
  end

  describe "when username is too short" do
    before { @user.username = 'a' }
    
    it { should_not be_valid }
  end

  describe "when email is blank" do
    before { @user.email = "  " }

    it { should_not be_valid }
  end

  describe "invalid passwords" do
    context "blank password" do
      before { @user.password = "  " }

      it { should_not be_valid }
    end

    context "password too short" do
      before { @user.password = "asd" }

      it { should_not be_valid }
    end
  end
end
