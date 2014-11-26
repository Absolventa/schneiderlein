require 'rails_helper'

RSpec.describe Schneiderlein::ExtractREXMLErrorMessage do

  let(:sample_message) { "#<REXML::ParseException: Some nice Foo Last 80 unconsumed characters:" }
  let(:exception)      { double }

  describe '#to_s' do
    it 'delivers only core message' do
      core_message  = 'Some nice Foo'
      expect(exception).to receive(:message).and_return(sample_message)
      expect(described_class.new(exception).to_s).to eql core_message
    end
  end

end
