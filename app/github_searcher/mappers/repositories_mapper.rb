module Mappers
  class RepositoriesMapper

    def map(response_body)
      repositories = response_body.map do |response_hash|
        Domain::Repository.build_from_hash(response_hash)
      end
      Domain::Repositories.new(repositories: repositories)
    end

  end
end