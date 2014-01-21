require 'spec_helper'

describe ProfilesController do
  let(:user) { FactoryGirl.create(:user) }
  
  describe "GET 'edit'" do
    it "returns http success" do
      get :edit, user_id: user
      response.should be_success
    end
  end

end
