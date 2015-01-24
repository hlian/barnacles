class << Rails.application
  def domain
    "barnacles.blackfriday"
  end

  def name
    "Barnacles"
  end
end

Rails.application.routes.default_url_options[:host] = Rails.application.domain
Rails.application.routes.default_url_options[:protocol] = "https"
