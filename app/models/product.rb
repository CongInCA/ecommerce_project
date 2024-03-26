class Product < ApplicationRecord
    belongs_to :category
    has_one_attached :image

    include Kaminari::PageScopeMethods

    def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "description", "id", "id_value", "name", "price", "updated_at"]
    end

    def self.ransackable_associations(auth_object = nil)
    ["category"]
    end
    
    def self.search(query)
        if query.present?
          where("name LIKE ? OR description LIKE ?", "%#{query}%", "%#{query}%")
        else
          all
        end
      end
end
