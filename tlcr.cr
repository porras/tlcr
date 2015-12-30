require "./src/tlcr"
require "option_parser"

Tlcr::Completion.setup

ARGV << "-h" if ARGV.empty?

ttl = 30.days
command = nil

parser = OptionParser.new do |parser|
  parser.banner = "Usage: #{$0} [options] [command]"
  parser.on("-u", "--update", "Force update (default: cache for #{ttl.total_days} days)") { ttl = 0.seconds }
  parser.on("-h", "--help", "Show this help") { Tlcr.fail parser }
  parser.unknown_args do |args|
    Tlcr.fail parser if args.size > 1
    command = args.first
  end
end

begin
  parser.parse!
rescue e : OptionParser::InvalidOption
  Tlcr.fail e.message, "", parser
end

if command
  client = Tlcr::Client.new(Tlcr::HTTP.new, Tlcr::Cache.new(ttl: ttl))
  if page = client.get(command)
    page.to_s(STDOUT)
  else
    Tlcr.fail "No entry for command: #{command}"
  end
else
  puts "Please specify a command name (or -h for help)"
end
