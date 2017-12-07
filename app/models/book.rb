class Book < ActiveRecord::Base
    def self.search(search)
      where(title: search)
    end
end