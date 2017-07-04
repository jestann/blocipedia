require 'rails_helper'

RSpec.describe ChargesController, type: :controller do

  # Not sure how to do testing for Stripe integration

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

end
