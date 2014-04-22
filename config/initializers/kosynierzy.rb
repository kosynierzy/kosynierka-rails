Rails.application.config.middleware.use OmniAuth::Builder do
  provider :kosynierzy, Kosynierka::Application.secrets.kosynierzy_key, Kosynierka::Application.secrets.kosynierzy_secret
end
