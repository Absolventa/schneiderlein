# frozen_string_literal: true
module Schneiderlein
  class FlyCatcher < Struct.new(:app)
    def call(env)
      begin
        app.call(env)
      rescue ActionDispatch::Http::Parameters::ParseError => e
        env['rack.schneiderlein.parse_errors'] ||= []
        env['rack.schneiderlein.parse_errors'] << e
        app.call(remove_errors_from(env))
      end
    end

    private

    def remove_errors_from(env)
      env['rack.input']     = StringIO.new
      env['rack.errors']    = StringIO.new
      env['RAW_POST_DATA']  = ''
      env['CONTENT_LENGTH'] = '0'
      env
    end

  end
end
