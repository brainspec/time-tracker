Rails.application.config.middleware.use OmniAuth::Builder do
  provider :'37signals', ENV['37SIGNALS_ID'], ENV['37SIGNALS_SECRET']
end
