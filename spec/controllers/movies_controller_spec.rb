require 'spec_helper'

describe MoviesController do
  describe "GET #search" do
    it "responds with a 200 status" do
      get :search
      binding.pry
      expect(response.status).to eq(200)
    end
  end
end
