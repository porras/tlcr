require "./spec_helper"

describe Tlcr::CLI do
  it "empty shows help" do
    expect_raises Tlcr::CLI::ShowHelp do
      Tlcr::CLI.parse([] of String)
    end
  end

  it "-h shows help" do
    expect_raises Tlcr::CLI::ShowHelp do
      Tlcr::CLI.parse(%w(-h))
    end
  end

  it "shows requested command (using cache)" do
    options = Tlcr::CLI.parse(%w(wadus))

    options.command.should eq("wadus")
    options.ttl.should eq(30.days)
  end

  it "-u disables the cache" do
    options = Tlcr::CLI.parse(%w(-u wadus))

    options.command.should eq("wadus")
    options.ttl.should eq(0.seconds)
  end

  it "-u alone shows help" do
    expect_raises Tlcr::CLI::ShowHelp do
      Tlcr::CLI.parse(%w(-u))
    end
  end

  it "-r enables local rendering" do
    options = Tlcr::CLI.parse(%w(-r wadus))

    options.command.should eq("wadus")
    options.local?.should eq(true)
  end

  it "-r alone shows help" do
    expect_raises Tlcr::CLI::ShowHelp do
      Tlcr::CLI.parse(%w(-r))
    end
  end
end
