require "rails_helper"

RSpec.describe Api::V1::UsersController, :type => :controller do
  include Helpers
  render_views
  let(:current_user) { FactoryBot.create(:user) }
  let(:new_user) {
    {
      user: {
        username: 'woompa',
        name: 'Woompa Loompa',
        email: 'woompa@loompa.com',
        password: '42424242',
      }
    }
  }

  describe 'POST create' do
    it 'creates a new user' do
      post :create, params: new_user
        expect(response.status).to eq(201)
    end
  end

  describe 'GET show' do
    it 'shows user data' do
      request.headers.merge!(authenticated_header(current_user))
      get :show, params: { id: current_user.id }
        parsed_body = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(parsed_body["name"]).to eq(current_user.name)
    end
  end

end
