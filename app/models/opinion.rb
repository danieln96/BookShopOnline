class Opinion < ApplicationRecord
    validates :description, presence: true, length: {minimum: 3, maximum: 1000}
    validates :rate, presence: true
end