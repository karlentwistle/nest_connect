require 'spec_helper'

RSpec.describe NestConnect::ChunkParser do
  describe '.write' do
    it 'ignores an empty string' do
      chunk = ""
      subject = NestConnect::ChunkParser.write('')
      expect(subject).to be(nil)
    end

    it 'unpacks a chunk with data' do
      chunk = "event: put\ndata: {\"foo\": \"bar\"}\n"
      subject = NestConnect::ChunkParser.write(chunk)
      expect(subject).to eql({ foo: 'bar' })
    end

    it 'unpacks a chunk with null data' do
      chunk = "event: put\ndata: null\n"
      subject = NestConnect::ChunkParser.write(chunk)
      expect(subject).to eql(nil)
    end
  end
end
