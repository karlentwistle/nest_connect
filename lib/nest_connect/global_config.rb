module NestConnect
  class GlobalConfig
    DEFAULT_PATH = ENV["HOME"] + '/.nest_connect/config'

    def initialize(store = nil)
      @store = store || ConfigStore.new(DEFAULT_PATH)
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
