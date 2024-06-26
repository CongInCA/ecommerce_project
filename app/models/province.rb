class Province < ApplicationRecord
  has_many :users

  validates :name, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "gst_rate", "hst_rate", "id", "id_value", "name", "pst_rate", "updated_at"]
  end
end
