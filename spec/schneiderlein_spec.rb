require 'rails_helper'

RSpec.describe Schneiderlein do

  describe FridayHugsController, type: :request do
    let(:malformed) { "{ foo: }" }

    it 'passes proper params right through' do
      json = { hello: 'world' }.to_json
      expect { request_json!(json) }.not_to raise_error
      expect(request.env['rack.schneiderlein.parse_errors']).to be_blank
    end

    it 'catches errors from ActionDispatch::ParamsParser' do
      expect { request_json!  }.not_to raise_error
    end

    it 'stores the exception message in a Rack variable' do
      request_json!
      expect(request.env['rack.schneiderlein.parse_errors']).to be_a Array
      expect(request.env['rack.schneiderlein.parse_errors'].size).to eql 1
      expect(request.env['rack.schneiderlein.parse_errors'].first).to be_a ActionDispatch::ParamsParser::ParseError
    end

    def request_json!(json = nil)
      json ||= malformed
      post "/friday_hugs", json, { 'Content-Type' => 'application/json' }
    end

  end

end
