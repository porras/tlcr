require "completion"

module Tlcr
  class DummyHTTP
    def index_content
      {"commands" => [] of Nil}.to_json
    end

    def page_content(command)
      raise "This should never be called"
    end
  end

  class ReadOnlyCache < Cache
    def get(keys)
      if hit?(keys)
        read(keys)
      else
        yield
      end
    end

    private def set(keys)
      raise "This should never be called"
    end
  end

  module Completion
    macro setup
      completion :command do |comp|
        comp.on :command do
          http = Tlcr::DummyHTTP.new      # never request anything just for completion
          cache = Tlcr::ReadOnlyCache.new # never store dummy results
          client = Tlcr::Client.new(http, cache)

          comp.reply ["-h", "--help", "-u", "--update", "-r", "--render", "-d", "--download", "-v", "--version"]
          comp.reply client.index.available.map(&.name)
        end
      end
    end
  end
end
