require File.expand_path('../boot', __FILE__)

require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'rack/cors'

Bundler.require(*Rails.groups)

module Server
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true

    config.middleware.insert_before 0, 'Rack::Cors' do
      allow do
        origins '*'
        resource '*',
                 headers: :any,
                 methods: %i(get post put patch delete options head)
      end
    end
  end
end
