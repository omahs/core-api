module Trackable
  def track(trackable:, utm_params: {})
    trackable.create_utm!(utm_params) if trackable.utm.nil?
  rescue StandardError => e
    Reporter.log(e, { message: e.message })
  end
end
