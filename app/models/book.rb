class Book < ActiveRecord::Base
   has_many :book_categories
   has_many :categories, through: :book_categories
   has_attached_file :avatar, styles: { medium: "400x200>", thumb: "150x75>" }, default_url: "/images/:style/missing.png"
   validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
    def self.search(search, category)
      where("LOWER(#{category}) LIKE '%#{search.downcase}%'")
    end
end