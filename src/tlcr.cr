require "./tlcr/*"

module Tlcr
  PLATFORMS = {
    "darwin" => "osx",
    "linux"  => "linux",
  }

  macro platform
    {{PLATFORMS[`uname`.strip.downcase.stringify]}}
  end

  macro fail(*messages)
    {% for message in messages %}
    puts {{message}}
    {% end %}
    exit -1
  end
end
