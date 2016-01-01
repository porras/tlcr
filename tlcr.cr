require "./src/tlcr"
require "option_parser"

Tlcr::Completion.setup

ARGV << "-h" if ARGV.empty?

ttl = 30.days
command = nil
local = false

parser = OptionParser.new do |parser|
  parser.banner = "Usage: #{$0} [options] [command]"
  parser.on("-u", "--update", "Force update (default: cache for #{ttl.total_days} days)") { ttl = 0.seconds }
  parser.on("-r", "--render", "Render local file (for authors)") { local = true }
  parser.on("-h", "--help", "Show this help") { Tlcr.fail parser }
  parser.unknown_args do |args|
    Tlcr.fail parser if args.size > 1
    command = args.first?
  end
end

begin
  parser.parse!
rescue e : OptionParser::InvalidOption
  Tlcr.fail e.message, "", parser
end

if command
  source = if local
    Tlcr::Local.new(command.not_nil!)
  else
    Tlcr::Client.new(Tlcr::HTTP.new, Tlcr::Cache.new(ttl: ttl))
  end

  if page = source.get(command.not_nil!)
    page.to_s(STDOUT)
  else
    Tlcr.fail("Page not found: #{command}")
  end
else
  Tlcr.fail(parser)
end
