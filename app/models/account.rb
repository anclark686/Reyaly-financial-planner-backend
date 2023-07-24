class Account
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :start, type: Float
  field :total, type: Float
  field :end, type: Float
  # field :expenses, type: Array
  belongs_to :user
  has_and_belongs_to_many :expenses, class_name: Expense
  

  def to_s
    "name:#{self.name} - id:#{self._id} - expenses:#{self.expense_ids}"
  end
end
