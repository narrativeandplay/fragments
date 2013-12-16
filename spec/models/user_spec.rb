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
  
  it { should respond_to(:stories) }

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
