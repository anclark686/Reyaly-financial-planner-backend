class Paycheck
  include Mongoid::Document
  include Mongoid::Timestamps
  field :date, type: String
  field :income, type: Integer
  belongs_to :user
  has_one :saved_paycheck

  def to_s
    "date:#{self.date} - id:#{self._id} user: #{user_id}"
  end
end
