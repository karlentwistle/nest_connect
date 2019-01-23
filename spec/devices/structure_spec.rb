require 'spec_helper'

RSpec.describe NestConnect::Device::Structure do
  describe '.from_hash_collection' do
    it 'creates an array of protects from hash' do
      path = File.expand_path('../fixtures/structures.json', File.dirname(__FILE__))
      hash = JSON.parse(File.read(path), symbolize_names: true)

      subject = described_class.from_hash_collection(hash)

      expect(subject).to include(
        an_object_having_attributes(
          structure_id: "4MThjmvqeLr-V9ieUZSD_etWKDjoljZqdubYcj6jWMb5fAMd2U-IOQ"
        )
      )
    end
  end

  describe '.all' do
    it 'returns an array of structures from api_class' do
      path = File.expand_path('../fixtures/structures.json', File.dirname(__FILE__))
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
          structure_id: "4MThjmvqeLr-V9ieUZSD_etWKDjoljZqdubYcj6jWMb5fAMd2U-IOQ"
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
      remote_attributes = { name: 'foo', country_code: 'UK' }
      api_class = double(
        new: double(
          get: double(
            body: remote_attributes
          )
        )
      )
      subject = described_class.new(
        structure_id: 'structure_id',
        name: nil,
        country_code: 'UK',
        api_class: api_class
      )

      subject.reload

      expect(subject.name).to eql('foo')
      expect(subject.country_code).to eql('UK')
    end
  end

  describe '#away=' do
    it 'writes the away attribute' do
      api_class = spy(api_class)
      subject = described_class.new(
        structure_id: 'structure_id',
        away: nil,
        api_class: api_class
      )

      subject.away = 'home'

      expect(subject.away).to eql('home')
    end

    it 'raises an error if away is invalid' do
      api_class = spy(api_class)
      subject = described_class.new(
        structure_id: 'structure_id',
        away: nil,
        api_class: api_class
      )

      expect {
        subject.away = 'foo'
      }.to raise_error(NestConnect::ValueError, 'away must be ["home", "away"]')
    end

    it 'delegates request to api_class' do
      api_class = spy(api_class)
      subject = described_class.new(
        structure_id: 'structure_id',
        away: nil,
        api_class: api_class
      )

      subject.away = 'away'

      expect(api_class).to have_received(:new).with(resource_id: 'structure_id', access_token: nil)
      expect(api_class).to have_received(:put).with({away: 'away'})
    end
  end

  describe '#name=' do
    it 'writes the name attribute' do
      api_class = spy(api_class)
      subject = described_class.new(
        structure_id: 'structure_id',
        name: nil,
        api_class: api_class
      )

      subject.name = 'Home'

      expect(subject.name).to eql('Home')
    end

    it 'delegates request to api_class' do
      api_class = spy(api_class)
      subject = described_class.new(
        structure_id: 'structure_id',
        name: nil,
        api_class: api_class
      )

      subject.name = 'Home'

      expect(api_class).to have_received(:new).with(resource_id: 'structure_id', access_token: nil)
      expect(api_class).to have_received(:put).with({name: 'Home'})
    end
  end

  describe '#thermostats' do
    it 'returns an empty array if data contains no thermostats' do
      api_class = spy(api_class)
      subject = described_class.new(
        thermostats: nil,
        api_class: api_class
      )

      expect(subject.thermostats).to be_empty
    end

    it 'returns an array of thermostats if data contain thermostat data' do
      api_class = spy(api_class)
      subject = described_class.new(
        thermostats: ['device_id'],
        name: nil,
        api_class: api_class
      )

      expect(subject.thermostats).to all(be_a(NestConnect::Device::Thermostat))
    end
  end

  describe '#protects' do
    it 'returns an empty array if data contains no protects' do
      api_class = spy(api_class)
      subject = described_class.new(
        protects: nil,
        api_class: api_class
      )

      expect(subject.protects).to be_empty
    end

    it 'returns an array of protects if data contain thermostat data' do
      api_class = spy(api_class)
      subject = described_class.new(
        protects: ['device_id'],
        name: nil,
        api_class: api_class
      )

      expect(subject.protects).to all(be_a(NestConnect::Device::Thermostat))
    end
  end

  describe '#cameras' do
    it 'returns an empty array if data contains no cameras' do
      api_class = spy(api_class)
      subject = described_class.new(
        cameras: nil,
        api_class: api_class
      )

      expect(subject.cameras).to be_empty
    end

    it 'returns an array of cameras if data contain thermostat data' do
      api_class = spy(api_class)
      subject = described_class.new(
        cameras: ['device_id'],
        name: nil,
        api_class: api_class
      )

      expect(subject.cameras).to all(be_a(NestConnect::Device::Camera))
    end
  end
end
