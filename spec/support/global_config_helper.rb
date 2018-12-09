require 'tempfile'

module GlobalConfigHelper
  def stub_global_config_path
    NestConnect::GlobalConfig.path = Tempfile.new.path
  end

  def global_config
    NestConnect::GlobalConfig.new
  end
end

RSpec.configure do |config|
  config.include GlobalConfigHelper

  config.before(:each) do
    stub_global_config_path
  end
end
