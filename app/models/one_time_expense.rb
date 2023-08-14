class OneTimeExpense
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :amount, type: Float
  field :date, type: String
  belongs_to :user
  belongs_to :paycheck

  def to_s
    "name:#{self.name} - id:#{self._id} - amount:#{self.amount} - date:#{self.date}"
  end
end
