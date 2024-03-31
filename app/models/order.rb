class Order < ApplicationRecord
    belongs_to :user
    has_many :order_items

    def self.ransackable_associations(auth_object = nil)
        ["order_items", "user"]
      end
    
      def self.ransackable_attributes(auth_object = nil)
        ["created_at", "customer_id", "id", "id_value", "total_price", "updated_at", "user_id"]
      end
end
