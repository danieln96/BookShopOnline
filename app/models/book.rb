class Book < ActiveRecord::Base
    def self.search(search, category)
      where("LOWER(#{category}) LIKE '%#{search.downcase}%'")
    end
end