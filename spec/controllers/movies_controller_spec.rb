require 'spec_helper'

describe MoviesController do
  describe "GET #show" do
    it "responds with a 200 status" do
      get :show
      expect(response).to be_a_success
    end
  end


end
