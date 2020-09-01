require 'rails_helper'

describe Services::SearchString do
  let(:attributes) { { Authorization: "toke HASH" } }
  let(:resource_uri) { "https://api.github.com/repositories" }
  let(:search_string) { described_class.new }

  describe '#build_search_string' do
    context 'there are no attributes' do
      it 'returns the same resource uri' do
        uri = search_string.build_search_string(nil, resource_uri: resource_uri)
        expect(uri).to eq(resource_uri)
      end
    end

    context 'are query parameters' do
      let(:attributes) { { q: "ruby", sort: "stars", order: "desc", page: "2", per_page: "30"} }
      let(:uri_with_query_params) { "https://api.github.com/repositories?q=ruby&sort=stars&order=desc&page=2&per_page=30" }

      it 'creates a uri with query params' do
        uri = search_string.build_search_string(attributes, resource_uri: resource_uri)
        expect(uri).to eq(uri_with_query_params)
      end
    end
  end
end
