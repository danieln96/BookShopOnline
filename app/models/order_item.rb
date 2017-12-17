class OrderItem < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :order
    def self.search(search)
      where(order_id: search)
    end
end