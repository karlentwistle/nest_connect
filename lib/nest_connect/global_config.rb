module NestConnect
  class GlobalConfig
    DEFAULT_PATH = ENV["HOME"] + '/.nest_connect/config'

    unless defined? @@path
      @@path = nil
    end

    def self.path=(new_path)
      @@path = new_path
    end

    def self.path
      @@path || DEFAULT_PATH
    end

    def initialize(store = nil)
      @store = store || ConfigStore.new(self.class.path)
    end

    def access_token
      @_access_token ||= store[:access_token] || configure_access_token
    end

    def access_token=(token)
      store.save(:access_token, token)
    end

    private

      attr_reader :store

      def configure_access_token
        raise 'configure your access token first'
      end
  end
end
