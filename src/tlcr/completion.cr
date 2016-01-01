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
    def get(*keys)
      if hit?(*keys)
        read(*keys)
      else
        yield
      end
    end

    private def set(*keys)
      raise "This should never be called"
    end
  end

  module Completion
    macro setup
      if ARGV.first? && ARGV.first =~ /^--comp/
        http = Tlcr::DummyHTTP.new      # never request anything just for completion
        cache = Tlcr::ReadOnlyCache.new # never store dummy results
        client = Tlcr::Client.new(http, cache)
        completion :command do |comp|
          comp.reply :command, ["-h", "--help", "-u", "--update", "-r", "--render"] +
            client.index.available.map(&.name)
        end
        exit 0
      end
    end
  end
end
