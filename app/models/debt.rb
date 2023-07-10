class Debt
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :type, type: String
  field :owed, type: Float
  field :limit, type: Integer
  field :rate, type: Float
  field :payment, type: Float
  belongs_to :user

  def to_s
    "name:#{self.name} - id:#{self._id} - owed:#{self.owed}"
  end
end
