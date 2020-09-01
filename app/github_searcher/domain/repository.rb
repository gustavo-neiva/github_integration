module Domain
  class Repository
    attr_reader :full_name, :description, :stars, :forks, :author

    def self.build_from_hash(hash)
      full_name = hash.dig("full_name")
      description = hash.dig("description")
      stars = hash.dig("stargazers_count")
      forks = hash.dig("forks_count")
      author = hash.dig("owner", "login")
      new(full_name: full_name, description: description, stars: stars, forks: forks, author: author)
    end

    def initialize(full_name:, description:, stars:, forks:, author:)
      @full_name = full_name
      @description = description
      @stars = stars
      @forks = forks
      @author = author
    end

    def to_hash
      {
        full_name: self.full_name,
        description: self.description,
        stars: self.stars,
        forks: self.forks,
        author: self.author
      }
    end

  end
end