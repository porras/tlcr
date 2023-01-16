require "uri"

module Tlcr
  class Download
    ARCHIVE_URI = URI.parse("https://github.com/tldr-pages/tldr/archive/main.tar.gz")
    INDEX_URI   = URI.parse("https://tldr-pages.github.io/assets/index.json")

    def self.download(cache)
      new(cache).download
    end

    @cache : Tlcr::Cache

    def initialize(@cache)
    end

    def download
      in_temp_dir do |dir|
        puts "Downloading #{INDEX_URI}..."
        system "curl -sL #{INDEX_URI} > index"
        puts "Downloading #{ARCHIVE_URI}..."
        system "curl -sL #{ARCHIVE_URI} | tar xz"
        index = Index.from_json(File.read(File.join(dir, "index")))
        @cache.store ["index"], File.join(dir, "index")
        index.available.each do |page|
          @cache.store [page.default_platform, page.name], File.join(dir, "tldr-master", "pages", page.default_platform, "#{page.name}.md")
        end
        puts "#{index.available.size} pages stored"
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
