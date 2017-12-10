class OrderItem < ActiveRecord::Base
    def self.search(search)
      where(order_id: search)
    end
end