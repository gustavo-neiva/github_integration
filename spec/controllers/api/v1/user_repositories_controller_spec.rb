require "rails_helper"

RSpec.describe Api::V1::UserRepositoriesController, :type => :controller do
  include Helpers
  render_views
  let(:current_user) { FactoryBot.create(:user) }

  describe 'GET index' do
    context 'no pagination param' do
      let(:username) { "gustavoneiva" }
      it 'shows a list of repositories' do
        request.headers.merge!(authenticated_header(current_user))
        VCR.use_cassette('controllers/api/v1/repositories_controller/list_user_repositories') do
          get :index, params: { username: username }
          expect(response.headers).to have_key("link")
          expect(response.status).to eq(200)
        end
      end
    end

    context 'with pagination param' do
      let(:username) { 12118557 }
      it 'shows a list of repositories' do
        request.headers.merge!(authenticated_header(current_user))
        VCR.use_cassette('controllers/api/v1/repositories_controller/list_user_repositories_page') do
          get :index, params: { username: username, page: 2 }
          expect(response.headers).to have_key("link")
          expect(response.status).to eq(200)
        end
      end
    end
  end

end
