module Tlcr
  # TODO: Parse and render Markdown!
  class Page
    def initialize(@content)
    end

    def to_s(io)
      io.puts
      io << @content
    end
  end
end
