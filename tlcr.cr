require "./src/tlcr"

Tlcr::Completion.setup

options = begin
  Tlcr::CLI.parse(ARGV)
rescue e : Tlcr::CLI::ShowHelp
  Tlcr.fail(e.message)
end

if options.version?
  puts "#{$0} v#{Tlcr::VERSION}"
  exit 0
elsif options.download?
  Tlcr::Download.download(Tlcr::Cache.new)
else
  source = if options.local?
             Tlcr::Local.new
           else
             Tlcr::Client.new(Tlcr::HTTP.new, Tlcr::Cache.new(ttl: options.ttl))
           end

  if page = source.get(options.command)
    page.to_s(STDOUT)
  else
    Tlcr.fail("Page not found: #{options.command}")
  end
end
