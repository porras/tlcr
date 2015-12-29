module Tlcr
  # TODO: TTL, forced updates, progress bar
  class Cache
    def initialize(@directory = File.join(ENV["HOME"], ".tlcr"))
    end

    def get(*keys)
      unless File.exists?(filename(*keys))
        puts "Fetching #{keys.join("::")}..."
        set(*keys, yield)
      end
      read(*keys)
    end

    private def read(*keys)
      File.read(filename(*keys))
    end

    private def set(*keys, content)
      Dir.mkdir_p(File.dirname(filename(*keys)))
      File.write(filename(*keys), content)
    end

    private def filename(*keys)
      File.join(@directory, *keys)
    end
  end
end
