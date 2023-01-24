require 'rails_helper'

RSpec.describe "Tables", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/tables/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/tables/show"
      expect(response).to have_http_status(:success)
    end
  end

end
