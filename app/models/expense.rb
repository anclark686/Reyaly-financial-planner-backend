class Expense
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :amount, type: Integer
  field :due, type: Date
  belongs_to :user
end
