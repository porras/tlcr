require "./src/tlcr"
require "completion"

client = Tlcr::Client.new(Tlcr::HTTP.new, Tlcr::Cache.new)

if name = ARGV.first?
  if name =~ /^--comp/
    completion :command do |comp|
      comp.reply :command, client.index.available.map(&.name)
    end
  else
    if page = client.get(name)
      page.to_s(STDOUT)
    else
      puts "No entry for command: #{name}"
    end
  end
else
  puts "Please specify a command name"
end
