require 'spec_helper'

RSpec.describe NestConnect::API::Stream do
  let(:stdout) { StringIO.new }
  subject(:stream) { NestConnect::API::Stream.new(stdout: stdout) }

  describe '#run' do
    it 'outputs the response body' do
      global_config.access_token = 'foo'
      stub_request_success

      stream.run

      stdout.rewind
      expect(stdout.gets).to eql("hello")
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
