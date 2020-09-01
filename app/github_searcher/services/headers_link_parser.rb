module Services
  class HeadersLinkParser

    GITHU_API_URL = "https://api.github.com"
    API_VERSIONING_URL = "/api/v1"

    def parse(headers)
      links = {}
      parts = headers[:link].split(',')

      parts.each do |part, index|
        section = part.split(';')
        url = remove_base_url(section[0][/<(.*)>/,1])
        name = section[1][/rel="(.*)"/,1].to_sym
        links[name] = url
      end
      links
    end

    def links(headers)
      original_links = headers[:link]
      remove_base_url(original_links)
    end

    private

    def remove_base_url(url)
      url.gsub(GITHU_API_URL, API_VERSIONING_URL)
    end
  end
end
