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
      stored = request.env['rack.schneiderlein.parse_errors']

      expect(stored).to be_a Array
      expect(stored.size).to eql 1
      expect(stored.first).to be_a Schneiderlein::FlyCatcher::PARSE_ERROR_CONSTANT
    end

    def request_json!(json = nil)
      json ||= malformed
      post "/friday_hugs", params: json.to_s, headers: { 'Content-Type' => 'application/json' }
    end

  end

end
