module UseCases
  class SearchQueryRepositories
    SEARCH_REPOSITORIES_RESOURCES_URI = "search/repositories"

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

    def execute(params:)
      resources_string = @search_string.build_search_string(params, resource_uri: SEARCH_REPOSITORIES_RESOURCES_URI)
      api_response = @api_client.get(resources: resources_string)
      @response_factory.build_response(api_response)
    end
  end
end