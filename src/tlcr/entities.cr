require "json"

module Tlcr
  class Index
    JSON.mapping({
      commands: Set(Command),
    })

    def available
      @commands.select(&.available?)
    end

    def get(name)
      available.find do |command|
        command.name == name
      end
    end

    class Command
      JSON.mapping({
        name:     String,
        platform: Set(String),
      })

      def available?
        @platform.includes?("common") || @platform.includes?(Tlcr.platform)
      end

      # TODO: maybe more clever?
      def default_platform
        @platform.first
      end
    end
  end
end
