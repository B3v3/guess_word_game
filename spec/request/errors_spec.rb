require 'rails_helper'

RSpec.describe 'errors', :type => :request do
  describe "not_found" do
    it "returns http success" do
      get '/404'
      expect(response.status).to eq(404)
    end
  end
end
