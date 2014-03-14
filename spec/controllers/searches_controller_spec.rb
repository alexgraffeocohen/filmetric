require 'spec_helper'

describe SearchesController do
  describe "GET #search" do
    it 'responds with a 200 status code' do
      get :search
      expect(response).to be_a_success
    end
  end


end 
