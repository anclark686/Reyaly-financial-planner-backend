class SavedPaycheck
  include Mongoid::Document
  include Mongoid::Timestamps
  field :paycheck_id, type: String
  index({ paycheck_id: 1 }, { unique: true, name: "paycheck_index" })
  field :date, type: String
  field :expenses, type: Array

  belongs_to :user
  belongs_to :paycheck

  validates_uniqueness_of :paycheck

  def to_s
    "paycheck:#{self.paycheck_id} - id:#{self._id} - date:#{self.date} - expenses:#{self.expenses}"
  end
end
