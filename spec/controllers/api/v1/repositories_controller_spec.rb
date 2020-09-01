require "rails_helper"

RSpec.describe Api::V1::RepositoriesController, :type => :controller do
  include Helpers
  render_views
  let(:current_user) { FactoryBot.create(:user) }

  describe 'GET index' do
    context 'no pagination param' do
      it 'shows a list of repositories' do
        request.headers.merge!(authenticated_header(current_user))
        VCR.use_cassette('controllers/api/v1/repositories_controller/list_repositories') do
          get :index
          expect(response.headers).to have_key("link")
          expect(response.status).to eq(200)
        end
      end
    end

    context 'with pagination param' do
      it 'shows a list of repositories' do
        request.headers.merge!(authenticated_header(current_user))
        VCR.use_cassette('controllers/api/v1/repositories_controller/list_repositories_since') do
          get :index, params: { since: 42 }
          expect(response.headers).to have_key("link")
          expect(response.status).to eq(200)
        end
      end
    end
  end

end
