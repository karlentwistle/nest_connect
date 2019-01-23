require 'spec_helper'

RSpec.describe NestConnect::Device::Thermostat do
  describe '.from_hash_collection' do
    it 'creates an array of thermostats from hash' do
      path = File.expand_path('../fixtures/thermostats.json', File.dirname(__FILE__))
      hash = JSON.parse(File.read(path), symbolize_names: true)

      subject = described_class.from_hash_collection(hash)

      expect(subject).to include(
        an_object_having_attributes(
          device_id: "2vwN8MnK9Ycnpwi1sBA31oiVurFRI2km"
        )
      )
    end
  end

  describe '.all' do
    it 'returns an array of thermostats from api_class' do
      path = File.expand_path('../fixtures/thermostats.json', File.dirname(__FILE__))
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
          device_id: "2vwN8MnK9Ycnpwi1sBA31oiVurFRI2km"
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
      remote_attributes = { label: 'foo', temperature_scale: 'F' }
      api_class = double(
        new: double(
          get: double(
            body: remote_attributes
          )
        )
      )
      subject = described_class.new(
        device_id: 'device_id',
        label: nil,
        temperature_scale: nil,
        api_class: api_class
      )

      subject.reload

      expect(subject.label).to eql('foo')
      expect(subject.temperature_scale).to eql('F')
    end
  end

  describe '#target_temperature_f=' do
    it 'writes the target_temperature_f attribute' do
      api_class = spy(api_class)
      subject = described_class.new(
        device_id: 'device_id',
        target_temperature_f: nil,
        api_class: api_class
      )

      subject.target_temperature_f = 64

      expect(subject.target_temperature_f).to eql(64)
    end

    it 'converts number to full degrees Fahrenheit (1°F)' do
      api_class = spy(api_class)
      subject = described_class.new(
        device_id: 'device_id',
        target_temperature_f: nil,
        api_class: api_class
      )

      subject.target_temperature_f = 64.58

      expect(subject.target_temperature_f).to eql(65)
    end

    it 'raises an error if target_temperature too low' do
      api_class = spy(api_class)
      subject = described_class.new(
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
      subject = described_class.new(
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
      subject = described_class.new(
        device_id: 'device_id',
        target_temperature_f: nil,
        api_class: api_class
      )

      subject.target_temperature_f = 64.58

      expect(api_class).to have_received(:new).with(resource_id: 'device_id', access_token: nil)
      expect(api_class).to have_received(:put).with({target_temperature_f: 65})
    end
  end

  describe '#target_temperature_c=' do
    it 'writes the target_temperature_c attribute' do
      api_class = spy(api_class)
      subject = described_class.new(
        device_id: 'device_id',
        target_temperature_c: nil,
        api_class: api_class
      )

      subject.target_temperature_c = 18.0

      expect(subject.target_temperature_c).to eql(18.0)
    end

    it 'converts number to half degrees Celsius (0.5°C)' do
      api_class = spy(api_class)
      subject = described_class.new(
        device_id: 'device_id',
        target_temperature_c: nil,
        api_class: api_class
      )

      subject.target_temperature_c = 19.6

      expect(subject.target_temperature_c).to eql(19.5)
    end

    it 'raises an error if target_temperature too low' do
      api_class = spy(api_class)
      subject = described_class.new(
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
      subject = described_class.new(
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
      subject = described_class.new(
        device_id: 'device_id',
        target_temperature_c: nil,
        api_class: api_class
      )

      subject.target_temperature_c = 19.6

      expect(api_class).to have_received(:new).with(resource_id: 'device_id', access_token: nil)
      expect(api_class).to have_received(:put).with({target_temperature_c: 19.5})
    end
  end

  describe '#fan_timer_active=' do
    it 'writes the fan_timer_active attribute' do
      api_class = spy(api_class)
      subject = described_class.new(
        device_id: 'device_id',
        fan_timer_active: nil,
        api_class: api_class
      )

      subject.fan_timer_active = true

      expect(subject.fan_timer_active).to eql(true)
    end

    it 'delegates request to api_class' do
      api_class = spy(api_class)
      subject = described_class.new(
        device_id: 'device_id',
        fan_timer_active: nil,
        api_class: api_class
      )

      subject.fan_timer_active = false

      expect(api_class).to have_received(:new).with(resource_id: 'device_id', access_token: nil)
      expect(api_class).to have_received(:put).with({fan_timer_active: false})
    end
  end

  describe '#fan_timer_duration=' do
    it 'writes the fan_timer_duration attribute' do
      api_class = spy(api_class)
      subject = described_class.new(
        device_id: 'device_id',
        fan_timer_duration: nil,
        api_class: api_class
      )

      subject.fan_timer_duration = 15

      expect(subject.fan_timer_duration).to eql(15)
    end

    it 'raises an error if fan_timer_duration is invalid' do
      api_class = spy(api_class)
      subject = described_class.new(
        device_id: 'device_id',
        fan_timer_duration: nil,
        api_class: api_class
      )

      expect {
        subject.fan_timer_duration = 20
      }.to raise_error(NestConnect::ValueError, 'fan_timer_duration must be [15, 30, 45, 60, 120, 240, 480, 720]')
    end

    it 'delegates request to api_class' do
      api_class = spy(api_class)
      subject = described_class.new(
        device_id: 'device_id',
        fan_timer_duration: nil,
        api_class: api_class
      )

      subject.fan_timer_duration = 720

      expect(api_class).to have_received(:new).with(resource_id: 'device_id', access_token: nil)
      expect(api_class).to have_received(:put).with({fan_timer_duration: 720})
    end
  end

  describe '#hvac_mode=' do
    it 'writes the hvac_mode attribute' do
      api_class = spy(api_class)
      subject = described_class.new(
        device_id: 'device_id',
        hvac_mode: nil,
        api_class: api_class
      )

      subject.hvac_mode = 'heat'

      expect(subject.hvac_mode).to eql('heat')
    end

    it 'raises an error if hvac_mode is invalid' do
      api_class = spy(api_class)
      subject = described_class.new(
        device_id: 'device_id',
        hvac_mode: nil,
        api_class: api_class
      )

      expect {
        subject.hvac_mode = 'foo'
      }.to raise_error(NestConnect::ValueError, 'hvac_mode must be ["heat", "cool", "heat-cool", "eco", "off"]')
    end

    it 'delegates request to api_class' do
      api_class = spy(api_class)
      subject = described_class.new(
        device_id: 'device_id',
        hvac_mode: nil,
        api_class: api_class
      )

      subject.hvac_mode = 'cool'

      expect(api_class).to have_received(:new).with(resource_id: 'device_id', access_token: nil)
      expect(api_class).to have_received(:put).with({hvac_mode: 'cool'})
    end
  end

  describe '#label=' do
    it 'writes the label attribute' do
      api_class = spy(api_class)
      subject = described_class.new(
        device_id: 'device_id',
        label: nil,
        api_class: api_class
      )

      subject.label = 'Upstairs'

      expect(subject.label).to eql('Upstairs')
    end

    it 'delegates request to api_class' do
      api_class = spy(api_class)
      subject = described_class.new(
        device_id: 'device_id',
        label: nil,
        api_class: api_class
      )

      subject.label = 'Playroom'

      expect(api_class).to have_received(:new).with(resource_id: 'device_id', access_token: nil)
      expect(api_class).to have_received(:put).with({label: 'Playroom'})
    end
  end

  describe '#target_temperature_high_c=' do
    it 'writes the target_temperature_high_c attribute' do
      api_class = spy(api_class)
      subject = described_class.new(
        device_id: 'device_id',
        target_temperature_high_c: nil,
        api_class: api_class
      )

      subject.target_temperature_high_c = 18.0

      expect(subject.target_temperature_high_c).to eql(18.0)
    end

    it 'converts number to half degrees Celsius (0.5°C)' do
      api_class = spy(api_class)
      subject = described_class.new(
        device_id: 'device_id',
        target_temperature_high_c: nil,
        api_class: api_class
      )

      subject.target_temperature_high_c = 19.6

      expect(subject.target_temperature_high_c).to eql(19.5)
    end

    it 'sends a request api_class' do
      api_class = spy(api_class)
      subject = described_class.new(
        device_id: 'device_id',
        target_temperature_high_c: nil,
        api_class: api_class
      )

      subject.target_temperature_high_c = 19.6

      expect(api_class).to have_received(:new).with(resource_id: 'device_id', access_token: nil)
      expect(api_class).to have_received(:put).with({target_temperature_high_c: 19.5})
    end
  end

  describe '#target_temperature_low_c=' do
    it 'writes the target_temperature_low_c attribute' do
      api_class = spy(api_class)
      subject = described_class.new(
        device_id: 'device_id',
        target_temperature_low_c: nil,
        api_class: api_class
      )

      subject.target_temperature_low_c = 18.0

      expect(subject.target_temperature_low_c).to eql(18.0)
    end

    it 'converts number to half degrees Celsius (0.5°C)' do
      api_class = spy(api_class)
      subject = described_class.new(
        device_id: 'device_id',
        target_temperature_low_c: nil,
        api_class: api_class
      )

      subject.target_temperature_low_c = 19.6

      expect(subject.target_temperature_low_c).to eql(19.5)
    end

    it 'sends a request api_class' do
      api_class = spy(api_class)
      subject = described_class.new(
        device_id: 'device_id',
        target_temperature_low_c: nil,
        api_class: api_class
      )

      subject.target_temperature_low_c = 19.6

      expect(api_class).to have_received(:new).with(resource_id: 'device_id', access_token: nil)
      expect(api_class).to have_received(:put).with({target_temperature_low_c: 19.5})
    end
  end

  describe '#target_temperature_high_f=' do
    it 'writes the target_temperature_high_f attribute' do
      api_class = spy(api_class)
      subject = described_class.new(
        device_id: 'device_id',
        target_temperature_high_f: nil,
        api_class: api_class
      )

      subject.target_temperature_high_f = 18.0

      expect(subject.target_temperature_high_f).to eql(18)
    end

    it 'converts number to full degrees Fahrenheit (1°F)' do
      api_class = spy(api_class)
      subject = described_class.new(
        device_id: 'device_id',
        target_temperature_high_f: nil,
        api_class: api_class
      )

      subject.target_temperature_high_f = 64.58

      expect(subject.target_temperature_high_f).to eql(65)
    end

    it 'sends a request api_class' do
      api_class = spy(api_class)
      subject = described_class.new(
        device_id: 'device_id',
        target_temperature_high_f: nil,
        api_class: api_class
      )

      subject.target_temperature_high_f = 19.6

      expect(api_class).to have_received(:new).with(resource_id: 'device_id', access_token: nil)
      expect(api_class).to have_received(:put).with({target_temperature_high_f: 20})
    end
  end

  describe '#target_temperature_low_f=' do
    it 'writes the target_temperature_low_f attribute' do
      api_class = spy(api_class)
      subject = described_class.new(
        device_id: 'device_id',
        target_temperature_low_f: nil,
        api_class: api_class
      )

      subject.target_temperature_low_f = 18.0

      expect(subject.target_temperature_low_f).to eql(18)
    end

    it 'converts number to full degrees Fahrenheit (1°F)' do
      api_class = spy(api_class)
      subject = described_class.new(
        device_id: 'device_id',
        target_temperature_low_f: nil,
        api_class: api_class
      )

      subject.target_temperature_low_f = 64.58

      expect(subject.target_temperature_low_f).to eql(65)
    end

    it 'sends a request api_class' do
      api_class = spy(api_class)
      subject = described_class.new(
        device_id: 'device_id',
        target_temperature_low_f: nil,
        api_class: api_class
      )

      subject.target_temperature_low_f = 19.6

      expect(api_class).to have_received(:new).with(resource_id: 'device_id', access_token: nil)
      expect(api_class).to have_received(:put).with({target_temperature_low_f: 20})
    end
  end

  describe '#temperature_scale=' do
    it 'writes the temperature_scale attribute' do
      api_class = spy(api_class)
      subject = described_class.new(
        device_id: 'device_id',
        temperature_scale: nil,
        api_class: api_class
      )

      subject.temperature_scale = 'F'

      expect(subject.temperature_scale).to eql('F')
    end

    it 'raises an error if temperature_scale is invalid' do
      api_class = spy(api_class)
      subject = described_class.new(
        device_id: 'device_id',
        temperature_scale: nil,
        api_class: api_class
      )

      expect {
        subject.temperature_scale = 'foo'
      }.to raise_error(NestConnect::ValueError, 'temperature_scale must be ["C", "F"]')
    end

    it 'delegates request to api_class' do
      api_class = spy(api_class)
      subject = described_class.new(
        device_id: 'device_id',
        temperature_scale: nil,
        api_class: api_class
      )

      subject.temperature_scale = 'C'

      expect(api_class).to have_received(:new).with(resource_id: 'device_id', access_token: nil)
      expect(api_class).to have_received(:put).with({temperature_scale: 'C'})
    end
  end
end
