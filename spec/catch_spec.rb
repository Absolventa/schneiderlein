require 'rails_helper'

RSpec.describe Schneiderlein::Catch do

  let(:request) { double(env: {}) }
  subject { described_class.new request }

  describe '#initialize' do
    it 'sets requests' do
      subject = described_class.new request
      expect(subject.request).to eql request
    end
  end

  describe '#to_a' do
    context 'without errors' do
      it 'returns an empty list' do
        expect(subject.to_a).to be_empty
      end
    end

    context 'with errors' do
      it 'returns a list of error messages' do
        errors = ['hello world']
        request.env['rack.schneiderlein.parse_errors'] = errors

        expect(subject.to_a).to eql errors
      end
    end
  end

  describe '#to_s' do
    context 'without errors' do
      it 'returns an empty string' do
        expect(subject.to_s).to eql ''
      end
    end

    context 'with errors' do
      it 'concatenates the errors' do
        errors = ['hello world']
        request.env['rack.schneiderlein.parse_errors'] = errors

        expect(subject.to_s).to eql errors.join(' ')
      end
    end

  end

end
