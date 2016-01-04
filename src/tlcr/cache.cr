module Tlcr
  class Cache
    def initialize(@directory = File.join(ENV["HOME"], ".tlcr"), @ttl = 30.days)
    end

    def get(*keys)
      unless hit?(*keys)
        puts "Fetching #{keys.join("::")}..."
        set(*keys, yield)
      end
      read(*keys)
    end

    private def hit?(*keys)
      File.exists?(filename(*keys)) && Time.utc_now - File.stat(filename(*keys)).mtime < @ttl
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
