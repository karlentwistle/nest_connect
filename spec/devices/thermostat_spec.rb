require 'spec_helper'

RSpec.describe NestConnect::Device::Thermostat do
  describe '.from_hash' do
    it 'creates an array of thermostats from json' do
      path = File.expand_path('../fixtures/thermostats.json', File.dirname(__FILE__))
      hash = JSON.parse(File.read(path), symbolize_names: true)

      subject = NestConnect::Device::Thermostat.from_hash(hash)

      expect(subject).to include(
        an_object_having_attributes(
          device_id: "2vwN8MnK9Ycnpwi1sBA31oiVurFRI2km"
        )
      )
    end
  end

  describe 'target_temperature_f' do
    it 'writes the target_temperature_f attribute' do
      api_class = spy(api_class)
      subject = NestConnect::Device::Thermostat.new(
        device_id: 'device_id',
        target_temperature_f: nil,
        api_class: api_class
      )

      subject.target_temperature_f = 64

      expect(subject.target_temperature_f).to eql(64)
    end

    it 'converts number to full degrees Fahrenheit (1°F)' do
      api_class = spy(api_class)
      subject = NestConnect::Device::Thermostat.new(
        device_id: 'device_id',
        target_temperature_f: nil,
        api_class: api_class
      )

      subject.target_temperature_f = 64.58

      expect(subject.target_temperature_f).to eql(65)
    end

    it 'raises an error if target_temperature too low' do
      api_class = spy(api_class)
      subject = NestConnect::Device::Thermostat.new(
        device_id: 'device_id',
        target_temperature_f: nil,
        api_class: api_class
      )

      expect {
        subject.target_temperature_f = 49
      }.to raise_error(NestConnect::RangeError, 'target_temperature_f must be between 50..90')
    end

    it 'raises an error if target_temperature too high' do
      api_class = spy(api_class)
      subject = NestConnect::Device::Thermostat.new(
        device_id: 'device_id',
        target_temperature_f: nil,
        api_class: api_class
      )

      expect {
        subject.target_temperature_f = 91
      }.to raise_error(NestConnect::RangeError, 'target_temperature_f must be between 50..90')
    end

    it 'delegates request to api_class' do
      api_class = spy(api_class)
      subject = NestConnect::Device::Thermostat.new(
        device_id: 'device_id',
        target_temperature_f: nil,
        api_class: api_class
      )

      subject.target_temperature_f = 64.58

      expect(api_class).to have_received(:new).with('device_id')
      expect(api_class).to have_received(:run).with({target_temperature_f: 65})
    end
  end

  describe 'target_temperature_c' do
    it 'writes the target_temperature_c attribute' do
      api_class = spy(api_class)
      subject = NestConnect::Device::Thermostat.new(
        device_id: 'device_id',
        target_temperature_c: nil,
        api_class: api_class
      )

      subject.target_temperature_c = 18.0

      expect(subject.target_temperature_c).to eql(18.0)
    end

    it 'converts number to half degrees Celsius (0.5°C)' do
      api_class = spy(api_class)
      subject = NestConnect::Device::Thermostat.new(
        device_id: 'device_id',
        target_temperature_c: nil,
        api_class: api_class
      )

      subject.target_temperature_c = 19.6

      expect(subject.target_temperature_c).to eql(19.5)
    end

    it 'raises an error if target_temperature too low' do
      api_class = spy(api_class)
      subject = NestConnect::Device::Thermostat.new(
        device_id: 'device_id',
        target_temperature_c: nil,
        api_class: api_class
      )

      expect {
        subject.target_temperature_c = 8
      }.to raise_error(NestConnect::RangeError, 'target_temperature_c must be between 9..30')
    end

    it 'raises an error if target_temperature too high' do
      api_class = spy(api_class)
      subject = NestConnect::Device::Thermostat.new(
        device_id: 'device_id',
        target_temperature_c: nil,
        api_class: api_class
      )

      expect {
        subject.target_temperature_c = 31
      }.to raise_error(NestConnect::RangeError, 'target_temperature_c must be between 9..30')
    end

    it 'sends a request api_class' do
      api_class = spy(api_class)
      subject = NestConnect::Device::Thermostat.new(
        device_id: 'device_id',
        target_temperature_c: nil,
        api_class: api_class
      )

      subject.target_temperature_c = 19.6

      expect(api_class).to have_received(:new).with('device_id')
      expect(api_class).to have_received(:run).with({target_temperature_c: 19.5})
    end
  end
end
