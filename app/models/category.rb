class Category < ApplicationRecord
    has_many :products

    include Kaminari::PageScopeMethods

    validates :name, presence: true

    validates :description, presence: true

    validates :name, length: { maximum: 50 }
    
    def self.ransackable_associations(auth_object = nil)
        ["products"]
      end

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "description", "id", "id_value", "name", "updated_at"]
    end
end