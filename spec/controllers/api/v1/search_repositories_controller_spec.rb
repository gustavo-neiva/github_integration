require "rails_helper"

RSpec.describe Api::V1::SearchRepositoriesController, :type => :controller do
  include Helpers
  render_views
  let(:current_user) { FactoryBot.create(:user) }

  describe 'GET index' do
    context 'simple query param' do
      let(:query_params) { { q: "rails" } }
      it 'shows a list of repositories' do
        request.headers.merge!(authenticated_header(current_user))
        VCR.use_cassette('controllers/api/v1/repositories_controller/search_query_repositories') do
          get :index, params: query_params
          expect(response.headers).to have_key("link")
          expect(response.status).to eq(200)
        end
      end
    end

    context 'with multiple params' do
      let(:query_params) { { q: "tetris+language:ruby", sort: "stars", order: "desc", page: "2", per_page: "10"} }
      it 'shows a list of repositories' do
        request.headers.merge!(authenticated_header(current_user))
        VCR.use_cassette('controllers/api/v1/repositories_controller/search_query_repositories_multiple_params') do
          get :index, params: query_params
          parsed_body = JSON.parse(response.body)
          repositories_list = parsed_body["repositories"]
          expect(response.headers).to have_key("link")
          expect(repositories_list.length).to eq(10)
          expect(repositories_list.first["stars"]).to be >= repositories_list.last["stars"]
          expect(response.status).to eq(200)
        end
      end
    end
  end

end
