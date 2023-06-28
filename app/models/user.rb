class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :username, type: String
  field :uid, type: String
  index({ uid: 1 }, { unique: true, name: "uid_index" })
  field :pay, type: Integer
  field :pay_rate, type: String
  field :pay_freq, type: String
  has_many :expenses, dependent: :delete_all
end
