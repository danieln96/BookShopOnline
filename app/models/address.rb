class Address < ApplicationRecord
    belongs_to :user
    validates :first_name, :last_name, :street, :homenumber, :apartnumber, :postalcode, :city, :telnumber, presence: true
end