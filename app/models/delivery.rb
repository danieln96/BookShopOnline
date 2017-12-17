class Delivery < ActiveRecord::Base
    has_one :order
    validates :title, presence: true
    validates :price, presence: true
end