module UseCases
  class SearchUsersRepositories

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

    def execute(user:, page:)
      resource_uri = build_uri(user, page)
      search_params = page.nil? ? nil : { page: page }
      resources_string = @search_string.build_search_string(search_params, resource_uri: resource_uri)
      api_response = @api_client.get(resources: resources_string)
      @response_factory.build_response(api_response)
    end

    private

    def build_uri(user, page)
      if page.nil?
        return "users/#{user}/repos"
      end
      "user/#{user}/repos"
    end

  end
end