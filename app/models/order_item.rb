class OrderItem < ApplicationRecord
  belongs_to  :book
  belongs_to  :order
    def self.search(search)
      where(order_id: search)
    end
end