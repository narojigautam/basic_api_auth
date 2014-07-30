require "basic_api_auth/version"
require "hashkey_generator"
require 'basic_api_auth/railtie' if defined?(Rails)

module BasicApiAuth
  class Middleware
    include HashkeyGenerator
    @@authenticity_error = [401, {"Content-Type" => "text/plain"}, ['{ "message": "Authentication Failed" }']]
    @@hashkey_requirement_error = [401, {"Content-Type" => "text/plain"}, ['{ "message": "Hashkey is required for authentication" }']]

    def initialize(app, api_key)
      @app = app
      @api_key = api_key
    end

    def call(env)
      @params = Rack::Request.new(env).params
      @hashkey = @params.delete('hashkey')
      return @@hashkey_requirement_error unless @hashkey
      return @@authenticity_error unless authenticate_hashkey
      @app.call(env)
    end

    def authenticate_hashkey
      @hashkey == generate_hashkey_for(@params, @api_key)
    end
  end
end
