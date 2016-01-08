require "http/client"

module Tlcr
  class HTTP
    def initialize(@index_uri = URI.parse("https://tldr-pages.github.io/assets/index.json") : URI,
                   @base_uri = URI.parse("https://raw.githubusercontent.com/tldr-pages/tldr") : URI)
    end

    def index_content
      HTTP::Client.get(@index_uri).body
    end

    def page_content(command)
      HTTP::Client.get(@base_uri.to_s + "/master/pages/#{command.default_platform}/#{command.name}.md").body
    end
  end
end
