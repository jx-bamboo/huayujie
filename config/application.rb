require_relative 'boot'

require 'rails/all'

require 'pp'
require 'csv'
require 'nkf'



# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Src
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :cn
    config.encoding = "utf-8"
    config.active_record.default_timezone = 'UTC'
    config.time_zone = 'Tokyo'

  end
end
