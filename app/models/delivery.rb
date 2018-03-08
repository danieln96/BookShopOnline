class Delivery < ApplicationRecord
    belongs_to :order
    validates :title, presence: true
    validates :price, presence: true
end