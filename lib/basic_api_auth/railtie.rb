module BasicApiAuth
  class Railtie < Rails::Railtie
    initializer "basic_api_auth_railtie.configure_rails_initialization" do |config|
      api_key = YAML.load_file("#{Rails.root}/config/basic_api_auth_key.yml")["api_key"].to_s
      config.middleware.use BasicApiAuth::Middleware, api_key
    end
  end

end
