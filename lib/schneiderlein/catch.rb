module Schneiderlein
  class Catch
    attr_reader :request

    def initialize(request)
      @request = request
    end

    def to_a
      request.env.fetch('rack.schneiderlein.parse_errors', [])
    end

    def to_s
      to_a.join ' '
    end
  end
end
