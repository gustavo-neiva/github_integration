require 'rails_helper'

describe UseCases::SearchQueryRepositories do
  let(:api_client) { double(Services::GithubApi) }
  let(:response_factory) { double(Factories::ResponseFactory) }
  let(:response) { double(Services::GithubIntegrationResponse) }
  let(:search_string) { double(Services::SearchString) }
  let(:resource_uri) { UseCases::SearchQueryRepositories::SEARCH_REPOSITORIES_RESOURCES_URI }
  let(:resources_string) { "search/repositories?loompa=woompa&woompa=loompa" }
  let(:github_integration_response) { double(Services::GithubIntegrationResponse) }
  let(:params) { { woompa: "loompa" } }
  let(:call_history) { double }
  let(:use_case) do
    described_class.new(
      api_client: api_client,
      response_factory: response_factory,
      search_string: search_string,
    )
  end

  describe '#execute' do
    before(:each) do
      allow(params).to receive(:to_hash)
      allow(search_string).to receive(:build_search_string).with(params, resource_uri: resource_uri).and_return(resources_string)
      allow(api_client).to receive(:get).with(resources: resources_string).and_return(response)
      allow(response_factory).to receive(:build_response).with(response)
    end

    after(:each) do
      use_case.execute(params: params)
    end

    it 'creates a response object' do
      expect(search_string).to receive(:build_search_string).with(params, resource_uri: resource_uri).and_return(resources_string)
      expect(api_client).to receive(:get).with(resources: resources_string).and_return(response)
      expect(response_factory).to receive(:build_response).with(response)
    end
  end
end