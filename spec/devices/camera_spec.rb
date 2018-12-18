require 'spec_helper'

RSpec.describe NestConnect::Device::Camera do
  describe '.from_hash_collection' do
    it 'creates an array of protects from hash' do
      path = File.expand_path('../fixtures/cameras.json', File.dirname(__FILE__))
      hash = JSON.parse(File.read(path), symbolize_names: true)

      subject = NestConnect::Device::Camera.from_hash_collection(hash)

      expect(subject).to include(
        an_object_having_attributes(
          device_id: "bCKbUR5t6SKKuHXCZID8hMbg6FH_6sANB86MZCuYbS-Lax5AKGRHfw"
        )
      )
    end
  end

  describe '#reload' do
    it 'rewrites all attributes from the api_class' do
      remote_attributes = { name: 'foo', is_online: true }
      api_class = double(
        new: double(
          get: double(
            body: remote_attributes
          )
        )
      )
      subject = NestConnect::Device::Camera.new(
        device_id: 'device_id',
        name: nil,
        is_online: nil,
        api_class: api_class
      )

      subject.reload

      expect(subject.name).to eql('foo')
      expect(subject.is_online).to eql(true)
    end
  end

  describe '#is_streaming=' do
    it 'writes the is_streaming attribute' do
      api_class = spy(api_class)
      subject = NestConnect::Device::Camera.new(
        device_id: 'device_id',
        is_streaming: nil,
        api_class: api_class
      )

      subject.is_streaming = false

      expect(subject.is_streaming).to eql(false)
    end

    it 'delegates request to api_class' do
      api_class = spy(api_class)
      subject = NestConnect::Device::Camera.new(
        device_id: 'device_id',
        is_streaming: nil,
        api_class: api_class
      )

      subject.is_streaming = true

      expect(api_class).to have_received(:new).with('device_id')
      expect(api_class).to have_received(:put).with({is_streaming: true})
    end
  end
end
