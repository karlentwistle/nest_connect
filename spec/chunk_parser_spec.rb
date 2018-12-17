require 'spec_helper'

RSpec.describe NestConnect::ChunkParser do
  describe '.write' do
    it 'ignores an empty string' do
      chunk = ""
      subject = NestConnect::ChunkParser.write('')
      expect(subject).to be(nil)
    end
  end

  describe "#event" do
    it 'returns a chunks event' do
      chunk = "event: put\ndata: {\"foo\": \"bar\"}\n"
      subject = NestConnect::ChunkParser.new(chunk)
      expect(subject.event).to eql('put')
    end
  end

  describe "#data" do
    it 'returns a chunks data' do
      chunk = "event: put\ndata: {\"foo\": \"bar\"}\n"
      subject = NestConnect::ChunkParser.new(chunk)
      expect(subject.data).to eql({ foo: 'bar' })
    end

    it 'returns a chunks null data' do
      chunk = "event: put\ndata: null\n"
      subject = NestConnect::ChunkParser.new(chunk)
      expect(subject.data).to eql({})
    end
  end

  describe '#thermostats' do
    it 'returns an empty array if data doesnt contain a thermostat' do
      chunk = "event: put\ndata: {\"foo\": \"bar\"}\n"
      subject = NestConnect::ChunkParser.new(chunk)
      expect(subject.thermostats).to be_empty
    end

    it 'returns an empty array if chunks data is null' do
      chunk = "event: put\ndata: null\n"
      subject = NestConnect::ChunkParser.new(chunk)
      expect(subject.thermostats).to be_empty
    end

    it 'returns an array of thermostats if data contain thermostat data' do
      path = File.expand_path('./fixtures/example_data.json', File.dirname(__FILE__))
      chunk = File.read(path)
      subject = NestConnect::ChunkParser.new(chunk)

      expect(subject.thermostats).to all(be_a(NestConnect::Device::Thermostat))
    end
  end

  describe '#protects' do
    it 'returns an empty array if data doesnt contain a smoke_co_alarm' do
      chunk = "event: put\ndata: {\"foo\": \"bar\"}\n"
      subject = NestConnect::ChunkParser.new(chunk)
      expect(subject.protects).to be_empty
    end

    it 'returns an empty array if chunks data is null' do
      chunk = "event: put\ndata: null\n"
      subject = NestConnect::ChunkParser.new(chunk)
      expect(subject.protects).to be_empty
    end

    it 'returns an array of protects if data contain smoke_co_alarm data' do
      path = File.expand_path('./fixtures/example_data.json', File.dirname(__FILE__))
      chunk = File.read(path)
      subject = NestConnect::ChunkParser.new(chunk)

      expect(subject.protects).to all(be_a(NestConnect::Device::Protect))
    end
  end
end
