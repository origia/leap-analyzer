class Bump
  include Mongoid::Document

  before_create :set_time

  field :position, type: Integer
  field :time, type: DateTime

  protected
  def set_time
    self.time = Time.now
  end

end
