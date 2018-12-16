require 'spec_helper'

RSpec.describe NestConnect::API::Devices::Thermostat do
  subject(:thermostat) { NestConnect::API::Devices::Thermostat.new('device_id') }

  describe '#put' do
    it 'returns a response object' do
      global_config.access_token = 'foo'
      stub_put_request_success

      subject = thermostat.put({target_temperature_f: 70})

      expect(subject.status).to eql(200)
    end
  end

  def stub_put_request_success
    stub_request(:put, "https://developer-api.nest.com/devices/thermostats/device_id").
      with(
        body: "{\"target_temperature_f\":70}",
        headers: {
          'Authorization'=>'Bearer foo',
          'Content-Type'=>'application/json',
        }
      ).
      to_return(status: 200, body: "", headers: {})
  end
end
