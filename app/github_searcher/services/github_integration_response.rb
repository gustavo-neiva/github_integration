module Services
  class GithubIntegrationResponse

    attr_reader :repositories, :metadata, :links

    def initialize(metadata:, repositories:, links:)
      @metadata = metadata
      @repositories = repositories
      @links = links
    end

    def body
      {
        metadata: metadata_builder,
        repositories: self.repositories.to_hash
      }
    end

    def metadata_builder
      self.metadata.merge({repositories_counter: self.repositories.count})
    end

  end
end
