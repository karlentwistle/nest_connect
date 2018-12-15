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
end
