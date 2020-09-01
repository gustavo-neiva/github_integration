module Services
  class GithubApi
    BASE_URL = "https://api.github.com/"

    def self.build
      http_client = RestClient
      api_key = ENV['GITHUB_API_KEY']
      new(base_url: BASE_URL, http_client: http_client, api_key: api_key)
    end

    def initialize(base_url:, http_client:, api_key:)
      @base_url = base_url
      @http_client = http_client
      @api_key = api_key
    end

    def get(resources:)
      begin
        url = @base_url + resources
        @http_client.get(url, headers)
      rescue RestClient::Exceptions::Timeout
        raise Exceptions::TimeOutException.new
      rescue RestClient::Unauthorized
        raise Exceptions::UnauthorizedException.new
      rescue RestClient::NotFound
        raise Exceptions::NotFoundException.new
      end
    end

    private

    def headers
      { Authorization: "token #{@api_key}" }
    end
  end
end
