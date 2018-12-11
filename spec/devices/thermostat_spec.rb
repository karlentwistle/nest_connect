require 'spec_helper'

RSpec.describe NestConnect::Device::Thermostat do
  describe '.from_json_collection' do
    it 'creates an array of thermostats from json' do
      path = File.expand_path('../fixtures/thermostats.json', File.dirname(__FILE__))
      file = File.read(path)

      subject = NestConnect::Device::Thermostat.from_json_collection(file)

      expect(subject).to include(
        an_object_having_attributes(
          device_id: "2vwN8MnK9Ycnpwi1sBA31oiVurFRI2km"
        )
      )
    end
  end
end
