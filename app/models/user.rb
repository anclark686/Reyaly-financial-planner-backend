class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :username, type: String
  field :uid, type: String
  index({ uid: 1 }, { unique: true, name: "uid_index" })
  field :pay, type: Integer
  field :pay_rate, type: String
  field :pay_freq, type: String
  field :hours, type: Integer
  has_many :expenses, dependent: :delete_all
  accepts_nested_attributes_for :expenses, allow_destroy: true

  def to_s
    "username:#{self.username} - id:#{self._id} - uid:#{self.uid}"
  end
end
