Rails.application.config.tap do |config|
  config.app_title = 'Track my leave'
  config.proposition_title = 'Track my leave'
  config.product_type = 'service'

  # The following values are required by the phase banner
  config.phase = 'beta'
  config.feedback_url = '/feedback'
end
