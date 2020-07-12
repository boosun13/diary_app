class Blog < ApplicationRecord
    belongs_to :user
    has_many :comments

    
    def self.search(search)
        if search
            Blog.where(['content LIKE ?', "%#{search}%"])
        else
            Blog.all
        end
    end
end
