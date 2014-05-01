require 'spec_helper'

describe GenresController do
  before(:each) do
    @genre = create(:genre)
  end

  describe "GET #show" do
    it "responds with a 200 status" do
      get :show, id: @genre.id
      expect(response).to be_a_success
    end
  end

end