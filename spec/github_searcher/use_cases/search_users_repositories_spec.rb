require 'rails_helper'

describe UseCases::SearchUsersRepositories do
  let(:api_client) { double(Services::GithubApi) }
  let(:response_factory) { double(Factories::ResponseFactory) }
  let(:response) { double(Services::GithubIntegrationResponse) }
  let(:search_string) { double(Services::SearchString) }
  let(:resource_uri) { UseCases::SearchRepositories::REPOSITORIES_RESOURCES_URI }
  let(:resources_string) { "search/repositories?loompa=woompa&woompa=loompa" }
  let(:github_integration_response) { double(Services::GithubIntegrationResponse) }
  let(:use_case) do
    described_class.new(
      api_client: api_client,
      response_factory: response_factory,
      search_string: search_string,
    )
  end

  describe '#execute' do
    context 'page param is nil' do
      let(:user) { 'woompa_loompa' }
      let(:page) { nil }
      let(:resource_uri) { "users/woompa_loompa/repos" }

      before(:each) do
        allow(search_string).to receive(:build_search_string).with(nil, resource_uri: resource_uri).and_return(resources_string)
        allow(api_client).to receive(:get).with(resources: resources_string).and_return(response)
        allow(response_factory).to receive(:build_response).with(response)
      end

      after(:each) do
        use_case.execute(user: user, page: page)
      end

      it 'creates a response object' do
        expect(search_string).to receive(:build_search_string).with(nil, resource_uri: resource_uri).and_return(resources_string)
        expect(api_client).to receive(:get).with(resources: resources_string).and_return(response)
        expect(response_factory).to receive(:build_response).with(response)
      end
    end

    context 'page param is present' do
      let(:user) { '424242' }
      let(:page) { 42 }
      let(:resource_uri) { "user/424242/repos" }
      let(:params) { { page: page }}

      before(:each) do
        allow(search_string).to receive(:build_search_string).with(params, resource_uri: resource_uri).and_return(resources_string)
        allow(api_client).to receive(:get).with(resources: resources_string).and_return(response)
        allow(response_factory).to receive(:build_response).with(response)
      end

      after(:each) do
        use_case.execute(user: user, page: page)
      end

      it 'creates a response object' do
        expect(search_string).to receive(:build_search_string).with(params, resource_uri: resource_uri).and_return(resources_string)
        expect(api_client).to receive(:get).with(resources: resources_string).and_return(response)
        expect(response_factory).to receive(:build_response).with(response)
      end
    end
  end
end