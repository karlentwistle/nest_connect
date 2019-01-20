require 'spec_helper'

RSpec.describe NestConnect::API::Stream do
  let(:output) { StringIO.new }
  subject(:stream) { NestConnect::API::Stream.new(output: output) }

  describe '#access_token' do
    it 'allows access_token to be overwritten' do
      subject = NestConnect::API::Stream.new(output: output, access_token: '1234')
      expect(subject.access_token).to eql('1234')
    end
  end

  describe '#run' do
    it 'outputs the response body' do
      global_config.access_token = 'foo'
      stub_request_success

      stream.run

      output.rewind
      expect(output.gets).to eql("hello")
    end
  end

  def stub_request_success
    stub_request(:get, "https://developer-api.nest.com/").
      with(
        headers: {
          'Accept'=>'text/event-stream',
          'Authorization'=>'Bearer foo',
          'Cache-Control'=>'no-cache',
        }
      ).
      to_return(
        status: 200,
        body: "hello",
        headers: {}
      )
  end
end
