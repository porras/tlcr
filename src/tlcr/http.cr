require "http/client"

module Tlcr
  class HTTP
    def initialize(@uri = URI.parse("https://raw.githubusercontent.com/tldr-pages/tldr") : URI)
    end

    def index_content
      conn.get(@uri.path.not_nil! + "/master/pages/index.json").body
    end

    def page_content(command)
      conn.get(@uri.path.not_nil! + "/master/pages/#{command.default_platform}/#{command.name}.md").body
    end

    private def conn
      @_conn ||= ::HTTP::Client.new(@uri.host.not_nil!, @uri.port, @uri.scheme == "https")
    end
  end
end
