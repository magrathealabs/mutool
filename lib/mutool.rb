require 'mutool/version'

class Mutool
  class << Mutool
    def flags(ops = {})
      ops.map { |key, value| ["-#{key}", value] }
    end

    # Reference: https://mupdf.com/docs/manual-mutool-convert.html
    def convert(input, pages='1-N', ops = {})
      run(['mutool', 'convert', flags(ops), input, pages].flatten)
    end

    def clean(input, output, pages='1-N', ops = {})
      run(['mutool', 'clean', flags(ops), input, output, pages].flatten)
    end

    private

    def run(command)
      system(*command, out: File::NULL, err: File::NULL)
    end
  end
end
