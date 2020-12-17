RestClient.log =
  Object.new.tap do |proxy|
    def proxy.<<(message)
      Rails.logger.info message
    end
  end

logfile = Rails.root.join('log', 'restclient.log')
RestClient.log = Logger.new(logfile)