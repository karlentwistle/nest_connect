require 'spec_helper'

RSpec.describe NestConnect::API::Devices::Protect do
  subject(:protect) { described_class.new('device_id') }

  describe '#access_token' do
    it 'allows access_token to be overwritten' do
      subject = described_class.new('device_id', access_token: '1234')

      expect(subject.access_token).to eql('1234')
    end
  end

  describe '#get' do
    it 'returns a response object' do
      global_config.access_token = 'foo'
      stub_get_request_success

      subject = protect.get

      expect(subject.status).to eql(200)
    end
  end

  describe '#all' do
    it 'returns a response object' do
      global_config.access_token = 'foo'
      stub_all_request_success

      subject = protect.all

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

  def stub_all_request_success
    stub_request(:get, "https://developer-api.nest.com/devices/smoke_co_alarms").
      with(
        headers: {
          'Authorization'=>'Bearer foo',
          'Content-Type'=>'application/json',
        }).
      to_return(status: 200, body: "", headers: {})
  end
end
