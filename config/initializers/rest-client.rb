logfile = Rails.root.join('log', 'restclient.log')
RestClient.log = Logger.new(logfile)