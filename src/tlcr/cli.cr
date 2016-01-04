require "option_parser"

module Tlcr
  class CLI
    class ShowHelp < Exception
      def self.display(*messages)
        new(messages.map(&.to_s).join("\n"))
      end
    end

    property! :ttl, :command
    property? :local, :download, :version

    def initialize
      @ttl = 30.days
      @local = false
      @download = false
      @version = false
    end

    def self.parse(argv)
      new.tap do |options|
        parser = OptionParser.new do |parser|
          parser.banner = "Usage: #{$0} [options] [command]"
          parser.on("-u", "--update", "Force update (default: cache for #{options.ttl.total_days} days)") { options.ttl = 0.seconds }
          parser.on("-r", "--render", "Render local file (for authors)") { options.local = true }
          parser.on("-d", "--download", "Download the whole TLDR archive") { options.download = true }
          parser.on("-v", "--version", "Show version") { options.version = true }
          parser.on("-h", "--help", "Show this help") { raise ShowHelp.display(parser) }
          parser.unknown_args do |args|
            if options.download? || options.version?
              raise ShowHelp.display(parser) unless args.empty?
            else
              raise ShowHelp.display(parser) if args.size != 1
              options.command = args.first?
            end
          end
        end

        begin
          parser.parse(argv)
        rescue e : OptionParser::InvalidOption
          raise ShowHelp.display(e.message, "", parser)
        end
      end
    end
  end
end
