require 'rails_helper'

RSpec.describe "Agents", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/agents/index"
      expect(response).to have_http_status(:success)
    end
  end

end
