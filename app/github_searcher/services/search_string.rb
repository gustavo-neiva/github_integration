module Services
  class SearchString
    def build_search_string(attributes = {}, resource_uri:)
      if attributes
        return resource_uri + '?' + URI.encode_www_form(attributes)
      end
      resource_uri
    end
  end
end