module Tlcr
  class Download
    ARCHIVE_URL = "https://github.com/tldr-pages/tldr/archive/master.tar.gz"

    def self.download(cache)
      new(cache).download
    end

    def initialize(@cache)
    end

    def download
      print "Downloading #{ARCHIVE_URL}..."
      in_temp_dir do |dir|
        system "curl -sL #{ARCHIVE_URL} | tar xz"
        index = Index.from_json(File.read(File.join(dir, "tldr-master", "pages", "index.json")))
        index.available.each do |page|
          @cache.store page.default_platform, page.name, File.join(dir, "tldr-master", "pages", page.default_platform, "#{page.name}.md")
        end
        puts " #{index.available.size} pages stored"
      end
    end

    private def in_temp_dir
      dirname = File.join(Dir.tmpdir, rand(UInt32::MAX).to_s)
      Dir.mkdir(dirname)
      Dir.cd(dirname) do
        yield dirname
      end
    end
  end
end

class Dir
  def self.tmpdir
    if tmpdir = ENV["TMPDIR"]?
      tmpdir = tmpdir + File::SEPARATOR unless tmpdir.ends_with? File::SEPARATOR
    else
      tmpdir = "/tmp/"
    end
    tmpdir
  end
end
