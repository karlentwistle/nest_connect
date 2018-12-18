require 'spec_helper'

RSpec.describe NestConnect::API::Devices::Camera do
  subject(:camera) { NestConnect::API::Devices::Camera.new('device_id') }

  describe '#put' do
    it 'returns a response object' do
      global_config.access_token = 'foo'
      stub_put_request_success

      subject = camera.put({is_streaming: false})

      expect(subject.status).to eql(200)
    end
  end

  describe '#get' do
    it 'returns a response object' do
      global_config.access_token = 'foo'
      stub_get_request_success

      subject = camera.get

      expect(subject.status).to eql(200)
    end
  end

  def stub_put_request_success
    stub_request(:put, "https://developer-api.nest.com/devices/cameras/device_id").
      with(
        body: "{\"is_streaming\":false}",
        headers: {
          'Authorization'=>'Bearer foo',
          'Content-Type'=>'application/json',
        }).
      to_return(status: 200, body: "", headers: {})
  end

  def stub_get_request_success
   stub_request(:get, "https://developer-api.nest.com/devices/cameras/device_id").
    with(
       headers: {
        'Authorization'=>'Bearer foo',
        'Content-Type'=>'application/json',
       }).
     to_return(status: 200, body: "", headers: {})
  end
end
