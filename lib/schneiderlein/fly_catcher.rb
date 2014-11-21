module Schneiderlein
  class FlyCatcher < Struct.new(:app)
    def call(env)
      begin
        app.call(env)
      rescue ActionDispatch::ParamsParser::ParseError => e
        env['rack.schneiderlein.parse_errors'] = Array(e.message)

        env['rack.input']     = StringIO.new
        env['rack.errors']    = StringIO.new
        env['RAW_POST_DATA']  = ''
        env['CONTENT_LENGTH'] = '0'

        app.call(env)
      end
    end
  end
end
