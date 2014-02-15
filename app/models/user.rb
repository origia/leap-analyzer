class User
  include Mongoid::Document
  before_create :set_token

  field :location, type: Array
  field :token, type: String
  field :device_token, type: String

  index({ location: "2d" }, { min: -200, max: 200 })
  index({ token: 1 }, { unique: true, name: "token_index" })

  has_many :bumps

  def update_position(data)
    return false unless data.has_key?('latitude') && data.has_key?('longitude')
    self.location = [data['longitude'], data['latitude']]
    self.save
  end

  protected
  def set_token
    self.token = loop do
      token = SecureRandom.urlsafe_base64
      break token unless User.where(token: token).exists?
    end
  end
end
