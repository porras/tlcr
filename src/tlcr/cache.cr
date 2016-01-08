module Tlcr
  class Cache
    def initialize(@directory = File.join(ENV["HOME"], ".tlcr"), @ttl = 30.days)
    end

    def get(*keys)
      unless hit?(*keys)
        set(*keys, yield)
      end
      read(*keys)
    end

    def store(*keys, source_path)
      if !File.exists?(source_path)
        # Just ignore, because not storing is not fatal (it will result in a cache miss next time, being stored if
        # available), and TLDR index.json does somethimes include pages that don't exist
        return false
      end

      Dir.mkdir_p(File.dirname(filename(*keys)))
      system "cp #{source_path} #{filename(*keys)}"
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
