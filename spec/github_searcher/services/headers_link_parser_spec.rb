require 'rails_helper'

describe Services::HeadersLinkParser do
  let(:headers) do
    {
      :link=>"<https://api.github.com/user/12118557/repos?page=1>; rel=\"prev\", <https://api.github.com/user/12118557/repos?page=1>; rel=\"first\""
    }
  end
  let(:parser) { described_class.new }
  let(:parsed_headers) { {:first=>"/api/v1/user/12118557/repos?page=1", :prev=>"/api/v1/user/12118557/repos?page=1"} }
  describe '#parse' do
    it 'return a hash with the pagination links' do
      parsed_header = parser.parse(headers)
      expect(parsed_header).to eq(parsed_headers)
    end
  end
end

