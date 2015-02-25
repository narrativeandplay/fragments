require 'spec_helper'

describe UsersController do
  let(:user) { FactoryGirl.create(:user) }
  
  describe "GET 'show'" do
    it "assigns the requested user to @user" do
      get :show, id: user
      
      expect(assigns(:user)).to eq user
    end
    
    it "renders the 'show' view" do
      get :show, id: user
      
      expect(response).to render_template :show
    end
  end

end
