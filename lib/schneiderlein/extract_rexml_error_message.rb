# frozen_string_literal: true
module Schneiderlein
  class ExtractREXMLErrorMessage < Struct.new(:exception)

    def to_s
      sanitizer(exception.message)
    end

    private

    def sanitizer(str)
      str.to_s.gsub!('#<REXML::ParseException: ', '').to_s[0..str.to_s.index('Last').to_i-2]
    end

  end
end
