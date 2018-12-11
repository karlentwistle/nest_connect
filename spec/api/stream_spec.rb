require 'spec_helper'

RSpec.describe NestConnect::API::Stream do
  let(:output) { StringIO.new }
  subject(:stream) { NestConnect::API::Stream.new(output: output) }

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
