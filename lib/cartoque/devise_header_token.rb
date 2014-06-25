# This rack middleware adds an "api_token" parameters to the
# query string if the 'X-Api-Token' HTTP header is present,
# so that Devise authentication can work through this custom
# HTTP header like in the previous versions of Cartoque.
#
# TODO: the implementation is ugly, it should happen after params
# parsing but I didn't manage to find out how it's stored...
module Cartoque
  class DeviseHeaderToken
    def initialize(app)
      @app = app
    end

    def call(env)
      if api_token = env['HTTP_X_API_TOKEN']
        env['QUERY_STRING'] += '&' if env['QUERY_STRING'].present?
        env['QUERY_STRING'] += "api_token=#{api_token}"
      end
      @app.call(env)
    end
  end
end
