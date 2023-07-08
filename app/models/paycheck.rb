class Paycheck
  include Mongoid::Document
  include Mongoid::Timestamps
  field :date, type: String
  belongs_to :user

  def to_s
    "date:#{self.date} - id:#{self._id} user: #{user_id}"
  end
end
