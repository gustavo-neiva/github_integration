module Factories
  class ResponseFactory
    def self.build
      headers_parser = Services::HeadersLinkParser.new
      repositories_mapper = Mappers::RepositoriesMapper.new
      new(headers_parser: headers_parser, repositories_mapper: repositories_mapper)
    end

    def initialize(headers_parser:, repositories_mapper:)
      @headers_parser = headers_parser
      @repositories_mapper = repositories_mapper
    end

    def build_response(rest_client_response)
      headers = rest_client_response.headers
      metadata = @headers_parser.parse(headers)
      links = @headers_parser.links(headers)
      body = JSON.parse(rest_client_response.body)
      if body.is_a?(Hash)
        total_count = body.slice!("items")
        total_count = total_count.transform_keys(&:to_sym)
        metadata = metadata.merge(total_count)
        body = body["items"]
      end
      repositories = @repositories_mapper.map(body)
      Services::GithubIntegrationResponse.new(metadata: metadata, repositories: repositories, links: links)
    end
  end
end
