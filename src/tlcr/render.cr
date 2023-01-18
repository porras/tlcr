require "markdown"
require "colorize"

module Tlcr
  class Page
    @content : String

    def initialize(@content)
    end

    def to_s(io)
      io.puts
      Markdown.parse(@content, Renderer.new(io))
      io.puts
      io.puts
    end
  end

  # NOTE: This is not a general purpose Markdown text renderer.
  # It's very coupled to the conventions in https://github.com/tldr-pages/tldr/blob/main/CONTRIBUTING.md
  # It renders stuff according to the specific meanings mentioned there and ignores everything else
  class Renderer
    include Markdown::Renderer

    @io : IO
    @modes : Set(Symbol)
    @colors : Set(Symbol)
    @upcase : Bool

    def initialize(@io : IO)
      @modes = Set(Symbol).new
      @colors = Set(Symbol).new
      @upcase = false
    end

    def begin_paragraph
    end

    def end_paragraph
    end

    def begin_italic
    end

    def end_italic
    end

    def begin_bold
      @modes.add(:bold)
    end

    def end_bold
      @modes.delete(:bold)
    end

    def begin_header(level)
      @io << transform(" ")
      @modes.add(:reverse)
      @io << transform(" ")
      if level == 1
        @upcase = true
        @modes.add(:underline)
      end
    end

    def end_header(level)
      if level == 1
        @upcase = false
        @modes.delete(:underline)
      end
      @io << transform(" ")
      @modes.delete(:reverse)
    end

    def begin_inline_code
      @io << "  "
      @modes.add(:dim)
    end

    def end_inline_code
      @modes.delete(:dim)
    end

    def begin_code(language = nil)
      @modes.add(:dim)
    end

    def end_code
      @modes.delete(:dim)
    end

    def begin_unordered_list
    end

    def end_unordered_list
    end

    def begin_ordered_list
    end

    def end_ordered_list
    end

    def begin_list_item
      @modes.add(:bright)
    end

    def end_list_item
      @modes.delete(:bright)
    end

    def begin_link(url)
    end

    def end_link
    end

    def begin_quote
    end

    def end_quote
    end

    def image(url, alt)
    end

    def text(text)
      @io << transform(text)
    end

    def horizontal_rule
      @io << "\n"
    end

    private def transform(text)
      text = text.upcase if @upcase
      text = text.colorize
      @modes.each { |m| text = text.mode(m) }
      @colors.each { |c| text = text.fore(c) }
      text
    end
  end
end
