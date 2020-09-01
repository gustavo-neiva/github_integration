module Domain
  class Repositories
    def initialize(repositories: [])
      @repositories = repositories
    end

    def to_hash
      @repositories.map(&:to_hash)
    end

    def count
      @repositories.count
    end
  end
end
