require 'rails_helper'

describe Factories::ResponseFactory do
  let(:headers_parser) { double(Services::HeadersLinkParser) }
  let(:repositories_mapper) { double(Services::HeadersLinkParser) }
  let(:headers) { double }
  let(:metadata) { double }
  let(:links) { double }
  let(:reponse_factory) do
    described_class.new(
      headers_parser: headers_parser,
      repositories_mapper: repositories_mapper
    )
  end

  describe '#build_response' do
    context 'body is a hash' do
      let(:rest_client_response) {
        instance_double(
          RestClient::Response,
          body: {
            'items': []
          }.to_json)
      }

      before(:each) do
        allow(rest_client_response).to receive(:headers).and_return(headers)
        allow(headers_parser).to receive(:parse).with(headers).and_return(metadata)
        allow(headers_parser).to receive(:links).with(headers).and_return(links)
        allow(metadata).to receive(:merge)
        allow(repositories_mapper).to receive(:map)
      end

      it 'creates the response object' do
        repository = reponse_factory.build_response(rest_client_response)
        expect(repository).to be_a(Services::GithubIntegrationResponse)
      end
    end

    context 'body is an array' do
      let(:rest_client_response) {
        instance_double(
          RestClient::Response,
          body: [].to_json)
      }

      before(:each) do
        allow(rest_client_response).to receive(:headers).and_return(headers)
        allow(headers_parser).to receive(:parse).with(headers).and_return(metadata)
        allow(headers_parser).to receive(:links).with(headers).and_return(links)
        allow(metadata).to receive(:merge)
        allow(repositories_mapper).to receive(:map)
      end

      it 'creates the response object' do
        repository = reponse_factory.build_response(rest_client_response)
        expect(repository).to be_a(Services::GithubIntegrationResponse)
      end
    end
  end
end