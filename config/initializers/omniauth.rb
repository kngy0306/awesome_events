Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development? || Rails.evn.test?
    provider :github, "c8c2520834e3100883c0", "3d7a0e7a46617d7aee449d4332b79f56fe89de1b", {:provider_ignores_state => true}
  else
    provider :github,
      Rails.application.credentials.github[:client_id]
      Rails.application.credentials.github[:client_secret]
  end
end