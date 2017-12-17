class Delivery < ActiveRecord::Base
    belongs_to :order
    validates :title, presence: true
    validates :price, presence: true
    def self.inarray()
        array = []
        Delivery.all.each do |temp|
            array << ["#{temp.title} #{temp.price}", temp.id]
        end
        array
    end
end