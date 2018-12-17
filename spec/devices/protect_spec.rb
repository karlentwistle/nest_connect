require 'spec_helper'

RSpec.describe NestConnect::Device::Protect do
  describe '.from_hash_collection' do
    it 'creates an array of protects from hash' do
      path = File.expand_path('../fixtures/protects.json', File.dirname(__FILE__))
      hash = JSON.parse(File.read(path), symbolize_names: true)

      subject = NestConnect::Device::Protect.from_hash_collection(hash)

      expect(subject).to include(
        an_object_having_attributes(
          device_id: "JqASH_zDseagPjP6jNNUZ4iVurFRI2km"
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
      subject = NestConnect::Device::Protect.new(
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
end
