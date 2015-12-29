require "./src/tlcr"

client = Tlcr::Client.new(Tlcr::HTTP.new, Tlcr::Cache.new)

if name = ARGV.first?
  if page = client.get(name)
    page.to_s(STDOUT)
  else
    puts "No entry for command: #{name}"
  end
else
  puts "Please specify a command name"
end
