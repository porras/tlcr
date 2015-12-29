require "./tlcr/*"

module Tlcr
  PLATFORMS = {
    "Darwin" => "osx",
  }

  macro platform
    {{PLATFORMS[`uname`.strip.stringify]}}
  end
end
