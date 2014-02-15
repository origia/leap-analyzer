class User
  include Mongoid::Document
  before_create :set_token

  field :location, type: Array
  field :token, type: String

  index({ location: "2d" }, { min: -200, max: 200 })
  index({ token: 1 }, { unique: true, name: "token_index" })

  has_many :bumps

  protected
  def set_token
    self.token = loop do
      token = SecureRandom.urlsafe_base64
      break token unless User.where(token: token).exists?
    end
  end
end
