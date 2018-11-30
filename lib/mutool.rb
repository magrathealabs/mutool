require 'mutool/version'

class Mutool
  class << Mutool
    def flags(ops)
      ops.map { |key, value| ["-#{key}", "'#{value.gsub('"', '\"')}'"].join(" ") }.join(" ")
    end

    # Reference: https://mupdf.com/docs/manual-mutool-convert.html
    def convert(input, pages='1-N', ops)
      system "mutool convert #{flags(ops)} #{input} #{pages}"
      $?
    end
  end
end
