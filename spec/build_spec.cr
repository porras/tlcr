require "./spec_helper"

describe "building the binary" do
  it "creates a working binary" do
    `crystal tlcr.cr -- --version`.should match(%r{v#{Tlcr::VERSION}$})
  end
end
