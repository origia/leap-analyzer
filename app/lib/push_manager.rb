class PushManager
  def initialize
    if LeapAnalyzer.env == :development
      @apn = Houston::Client.development
    else
      @apn = Houston::Client.production
    end
    @apn.certificate = File.read(Settings.apn.pem_file)
    @apn.passphrase = Settings.apn.passphrase
  end

  def push(token, data)
    notification = Houston::Notification.new(device: token)
    notification.custom_data = data.reject { |k| k.to_sym == :token }
    notification.content_available = 1
    @apn.push(notification)
  end

  def self.push(token, data)
    @manager ||= PushManager.new
    @manager.push(token, data)
  end

end
