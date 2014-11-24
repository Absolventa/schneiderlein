require 'rails_helper'

RSpec.describe Schneiderlein::Catch do

  let(:request) { double(env: {}) }
  subject { described_class.new request }

  shared_context 'with rack errors' do
    let(:errors) { ['hello world'] }

    before do
      request.env['rack.schneiderlein.parse_errors'] = errors
    end
  end

  describe '#initialize' do
    it 'sets requests' do
      subject = described_class.new request
      expect(subject.request).to eql request
    end
  end

  describe '#empty?' do
    it 'returns true if errors are empty' do
      allow(subject).to receive(:errors).and_return []
      expect(subject).to be_empty
    end

    it 'returns false if errors are present' do
      allow(subject).to receive(:errors).and_return %w(stuff went pear-shaped)
      expect(subject).not_to be_empty
    end
  end

  describe '#errors' do
    context 'without errors' do
      it 'returns an empty list' do
        expect(subject.errors).to be_empty
      end
    end

    context 'with errors' do
      include_context 'with rack errors'

      it 'returns a list of error messages' do
        expect(subject.errors).to eql errors
      end
    end
  end

  describe '#to_a' do
    context 'without errors' do
      it 'returns an empty list' do
        expect(subject.to_a).to be_empty
      end
    end

    context 'with errors' do
      include_context 'with rack errors'

      it 'returns a list of error messages' do
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
      include_context 'with rack errors'

      it 'concatenates the errors' do
        expect(subject.to_s).to eql errors.join(' ')
      end
    end

  end

end
