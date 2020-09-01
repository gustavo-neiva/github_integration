require 'rails_helper'

describe Services::GithubApi do
  let(:api_client) { double(RestClient) }
  let(:api_key) { "42424242424242" }
  let(:base_url) { "https://api.github.com/" }
  let(:resources) { "repositories" }
  let(:resources) { "https://api.github.com/repositories" }
  let(:headers) { { Authorization: "toke HASH" } }
  let(:github_integration_response) { double(Services::GithubIntegrationResponse) }
  let(:api) do
    described_class.new(
      http_client: api_client,
      base_url: base_url,
      api_key: api_key,
    )
  end

  describe '#get' do
    context 'request is successful' do

      before(:each) do
        allow(api_client).to receive(:get).and_return(github_integration_response)
      end

      after(:each) do
        api.get(resources: resources)
      end

      it 'creates a response object' do
        expect(api_client).to receive(:get).and_return(github_integration_response)
      end
    end

    context 'timeout' do
      before(:each) do
        allow(api_client).to receive(:get).and_raise(RestClient::Exceptions::Timeout)
      end

      it 'raises TimeOutException' do
        expect{ api.get(resources: resources) }.to raise_error(Exceptions::TimeOutException)
      end
    end

    context 'unauthorized' do
      before(:each) do
        allow(api_client).to receive(:get).and_raise(RestClient::Unauthorized)
      end

      it 'raises UnauthorizedException' do
        expect{ api.get(resources: resources) }.to raise_error(Exceptions::UnauthorizedException)
      end
    end

    context 'not found' do
      before(:each) do
        allow(api_client).to receive(:get).and_raise(RestClient::NotFound)
      end

      it 'raises NotFoundException' do
        expect{ api.get(resources: resources) }.to raise_error(Exceptions::NotFoundException)
      end
    end
  end
end