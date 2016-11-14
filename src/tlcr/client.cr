module Tlcr
  class Client
    @http : Tlcr::HTTP | Tlcr::DummyHTTP
    @cache : Tlcr::Cache

    def initialize(@http, @cache)
    end

    def index
      Index.from_json(index_content)
    end

    def get(name : String)
      if command = index.get(name)
        Page.new(page_content(command))
      end
    end

    private def index_content
      @cache.get(["index"]) do
        puts "Fetching index..."
        @http.index_content
      end
    end

    private def page_content(command : Tlcr::Command)
      @cache.get([command.default_platform, command.name]) do
        puts "Fetching #{command.name}..."
        @http.page_content(command)
      end
    end
  end
end
