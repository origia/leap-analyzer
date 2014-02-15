class Bump
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  field :position, type: Integer

end
