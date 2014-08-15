require File.expand_path('../boot', __FILE__)

require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module Whovar
  class Application < Rails::Application
    config.assets.enabled = true
    config.assets.initialize_on_precompile = false
    config.assets.version = '20140816'

    config.generators.assets      = false
    config.generators.helper      = false
    config.generators.javascripts = false
    config.generators.stylesheets = false
    config.generators.view_tests  = false

    config.i18n.default_locale = :ja
    config.time_zone = 'Tokyo'
  end
end
