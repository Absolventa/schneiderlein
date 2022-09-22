module Schneiderlein
  class FlyCatcher < Struct.new(:app)

    PARSE_ERROR_CONSTANT =
      if Rails.version.to_f < 5.1
        ActionDispatch::ParamsParser::ParseError
      else
        ActionDispatch::Http::Parameters::ParseError
      end

    def call(env)
      app.call(env)
    rescue PARSE_ERROR_CONSTANT => e
      env['rack.schneiderlein.parse_errors'] ||= []
      env['rack.schneiderlein.parse_errors'] << e
      app.call(remove_errors_from(env))
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
