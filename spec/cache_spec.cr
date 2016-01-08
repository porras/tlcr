require "./spec_helper"

describe Tlcr::Cache do
  it "stores and fetches data" do
    cache = Tlcr::Cache.new(File.join(Dir.tmpdir, rand(1000).to_s))

    data = cache.get("a", "b") do
      "1"
    end

    data.should eq("1")

    data = cache.get("a", "c") do
      "2"
    end

    data.should eq("2")

    data = cache.get("a", "b") do
      raise "It shouldn't run this"
    end

    data.should eq("1")
  end

  it "honors ttl" do
    cache = Tlcr::Cache.new(File.join(Dir.tmpdir, rand(10000).to_s), ttl: 1.second)

    data = cache.get("a", "b") do
      "1"
    end

    data.should eq("1")

    data = cache.get("a", "b") do
      raise "It shouldn't run this"
    end

    data.should eq("1")

    sleep 1

    data = cache.get("a", "b") do
      "2"
    end

    data.should eq("2")
  end

  it "stores files" do
    cache = Tlcr::Cache.new(File.join(Dir.tmpdir, rand(1000).to_s), ttl: 1.seconds)

    cache.store("this", {{__FILE__}})

    data = cache.get("this") do
      raise "It shouldn't run this"
    end

    data.should eq(File.read({{__FILE__}}))
  end
end
