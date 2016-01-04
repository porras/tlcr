require "./src/tlcr"

Tlcr::Completion.setup

options = begin
  Tlcr::CLI.parse(ARGV)
rescue e : Tlcr::CLI::ShowHelp
  Tlcr.fail(e.message)
end

source = if options.local?
           Tlcr::Local.new(options.command)
         else
           Tlcr::Client.new(Tlcr::HTTP.new, Tlcr::Cache.new(ttl: options.ttl))
         end

if page = source.get(options.command)
  page.to_s(STDOUT)
else
  Tlcr.fail("Page not found: #{options.command}")
end
