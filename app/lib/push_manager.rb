class PushManager
  def initialize
    if LeapAnalyzer.env == :development
      @apn = Houston::Client.development
    else
      @apn = Houston::Client.production
    end
    @apn.certificate = File.read(Settings.apn.pem_file)
  end

  def push(token, data)
    notification = Houston::Notification.new(device: token)
    data.each { |k,v| notification.send(k, v) }
    APN.push(notification)
  end

end
