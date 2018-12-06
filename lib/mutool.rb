require 'mutool/version'

class Mutool
  class << Mutool
    attr_accessor :mutool_path, :has_mutool

    def has_mutool?
      @has_mutool ||= run([mutool_path]).exitstatus == 1
    end

    def flags(ops = {})
      ops.map { |key, value| ["-#{key}", value] }
    end

    # Reference: https://mupdf.com/docs/manual-mutool-convert.html
    def convert(input, pages='1-N', ops)
      raise 'mutool not found' unless has_mutool?
      run([mutool_path, 'convert', flags(ops), input, pages].flatten)
    end

    # https://mupdf.com/docs/manual-mutool-clean.html
    def clean(input, output, pages='1-N', ops)
      raise 'mutool not found' unless has_mutool?
      run([mutool_path, 'clean', flags(ops), input, output, pages].flatten)
    end

    private

    def mutool_path
      @mutool_path ||= ENV["MUTOOL_PATH"] || 'mutool'
    end

    def run(command = [])
      system(*command, out: File::NULL, err: File::NULL)
      $?
    end
  end
end
