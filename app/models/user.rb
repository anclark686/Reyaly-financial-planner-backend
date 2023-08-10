class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :username, type: String
  field :uid, type: String
  index({ uid: 1 }, { unique: true, name: "uid_index" })
  field :pay, type: Float
  field :rate, type: String
  field :frequency, type: String
  field :hours, type: Float
  field :date, type: String
  field :income, type: Integer
  field :pay2, type: Float
  field :rate2, type: String
  field :frequency2, type: String
  field :hours2, type: Float
  field :date2, type: String
  field :deductions, type: Integer
  field :residence, type: String
  field :relationship, type: String
  
  has_many :expenses, dependent: :delete_all
  accepts_nested_attributes_for :expenses, allow_destroy: true
  has_many :paychecks, dependent: :delete_all
  accepts_nested_attributes_for :paychecks, allow_destroy: true
  has_many :debts, dependent: :delete_all
  accepts_nested_attributes_for :debts, allow_destroy: true
  has_many :accounts, dependent: :delete_all
  accepts_nested_attributes_for :accounts, allow_destroy: true

  def to_s
    "username:#{self.username} - id:#{self._id} - uid:#{self.uid}"
  end
end
