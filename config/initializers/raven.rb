require 'raven'

Raven.configure do |config|
  config.dsn = Rails.application.secrets.raven_url
end
