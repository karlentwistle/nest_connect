require 'spec_helper'

RSpec.describe NestConnect::Device::Protect do
  describe '.from_hash_collection' do
    it 'creates an array of protects from hash' do
      path = File.expand_path('../fixtures/protects.json', File.dirname(__FILE__))
      hash = JSON.parse(File.read(path), symbolize_names: true)

      subject = described_class.from_hash_collection(hash)

      expect(subject).to include(
        an_object_having_attributes(
          device_id: "JqASH_zDseagPjP6jNNUZ4iVurFRI2km"
        )
      )
    end
  end

  describe '.all' do
    it 'returns an array of protects from api_class' do
      path = File.expand_path('../fixtures/protects.json', File.dirname(__FILE__))
      api_class = double(
        new: double(
          all: double(
            body: JSON.parse(File.read(path), symbolize_names: true)
          )
        )
      )
      subject = described_class.all(api_class: api_class)

      expect(subject).to include(
        an_object_having_attributes(
          device_id: "JqASH_zDseagPjP6jNNUZ4iVurFRI2km"
        )
      )
    end
  end

  describe '#access_token=' do
    it 'allows access_token to be overwritten' do
      subject = described_class.new(device_id: 'device_id')

      subject.access_token = '1234'

      expect(subject.access_token).to eql('1234')
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
      subject = described_class.new(
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
