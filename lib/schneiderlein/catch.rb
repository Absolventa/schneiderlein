module Schneiderlein
  class Catch
    delegate :any?, :empty?, to: :errors

    attr_reader :request

    def initialize(request)
      @request = request
    end

    def to_a
      request.env.fetch('rack.schneiderlein.parse_errors', [])
    end

    alias errors to_a

    def to_s
      to_a.map(&:to_s).join ' '
    end
  end
end
