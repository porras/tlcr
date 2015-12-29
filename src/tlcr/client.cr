module Tlcr
  class Client
    def initialize(@http, @cache)
    end

    def index
      Index.from_json(index_content)
    end

    def get(name)
      if command = index.get(name)
        Page.new(page_content(command))
      end
    end

    private def index_content
      @cache.get("index") do
        @http.index_content
      end
    end

    private def page_content(command)
      @cache.get(command.default_platform, command.name) do
        @http.page_content(command)
      end
    end
  end
end
