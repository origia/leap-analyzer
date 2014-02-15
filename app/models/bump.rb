class Bump
  include Mongoid::Document

  belongs_to: :user

  before_create :set_time

  field :position, type: Integer
  field :time, type: DateTime

  protected
  def set_time
    self.time = Time.now
  end

end
