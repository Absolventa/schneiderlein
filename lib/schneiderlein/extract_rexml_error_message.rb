module Schneiderlein
  class ExtractREXMLErrorMessage < Struct.new(:exception)

    def to_s
      sanitizer(exception.message)
    end

    private

    def sanitizer(str)
      string = str.to_s.dup
      string = string.gsub('#<REXML::ParseException: ', '')
      string = string.to_s[0..string.to_s.index('Last').to_i-2]
      string
    end

  end
end
