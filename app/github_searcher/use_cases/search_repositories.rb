module UseCases
  class SearchRepositories
    REPOSITORIES_RESOURCES_URI = "repositories"

    def self.build
      api_client = Services::GithubApi.build
      response_factory = Factories::ResponseFactory.build
      search_string = Services::SearchString.new
      new(api_client: api_client, response_factory: response_factory, search_string: search_string)
    end

    def initialize(api_client:, response_factory:, search_string:)
      @api_client = api_client
      @response_factory = response_factory
      @search_string = search_string
    end

    def execute(since:)
      search_params = since.nil? ? nil : { since: since }
      resources_string = @search_string.build_search_string(search_params, resource_uri: REPOSITORIES_RESOURCES_URI)
      api_response = @api_client.get(resources: resources_string)
      @response_factory.build_response(api_response)
    end
  end
end