require 'spec_helper'

describe DirectorsController do
  before(:each) do
    @director = create(:director)
  end

  describe "GET #show" do
    it "responds with a 200 status" do
      get :show, id: @director.id
      expect(response).to be_a_success
    end
  end

end