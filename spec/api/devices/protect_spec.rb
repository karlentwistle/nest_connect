require 'spec_helper'

RSpec.describe NestConnect::API::Devices::Protect do
  subject(:protect) { NestConnect::API::Devices::Protect.new('device_id') }

  describe '#get' do
    it 'returns a response object' do
      global_config.access_token = 'foo'
      stub_get_request_success

      subject = protect.get

      expect(subject.status).to eql(200)
    end
  end

  def stub_get_request_success
   stub_request(:get, "https://developer-api.nest.com/devices/smoke_co_alarms/device_id").
    with(
       headers: {
        'Authorization'=>'Bearer foo',
        'Content-Type'=>'application/json',
       }).
     to_return(status: 200, body: "", headers: {})
  end
end
