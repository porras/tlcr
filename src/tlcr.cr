require "./tlcr/*"

module Tlcr
  PLATFORMS = {
    "darwin" => "osx",
    "linux"  => "linux",
  }

  macro platform
    {{PLATFORMS[`uname`.strip.downcase.stringify]}}
  end
end
