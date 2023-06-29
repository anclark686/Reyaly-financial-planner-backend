class Expense
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :amount, type: Integer
  field :date, type: Integer
  belongs_to :user

  def to_s
    "name:#{self.name} - id:#{self._id} - amount:#{self.amount} - date:#{self.date}"
  end
end
