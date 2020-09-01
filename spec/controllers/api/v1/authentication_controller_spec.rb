require "rails_helper"

RSpec.describe Api::V1::AuthenticationController, :type => :controller do
  include Helpers
  render_views
  let(:current_user) { FactoryBot.create(:user) }
  let(:user_params) {
    {
        email: current_user.email,
        password: current_user.password,
    }
  }

  describe 'POST create' do
    it 'authenticate user' do
      post :create, params: user_params
        parsed_body = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(parsed_body.key?("token")).to eq(true)
    end
  end

end
