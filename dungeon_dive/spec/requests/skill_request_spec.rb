require 'rails_helper'

RSpec.describe "Skills", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/skill/index"
      expect(response).to have_http_status(:success)
    end
  end

end
