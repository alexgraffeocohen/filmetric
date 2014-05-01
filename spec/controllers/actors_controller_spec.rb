require 'spec_helper'

describe ActorsController do
  before(:each) do
    @actor = create(:actor)
  end

  describe "GET #show" do
    it "responds with a 200 status" do
      get :show, id: @actor.id
      expect(response).to be_a_success
    end
  end

end