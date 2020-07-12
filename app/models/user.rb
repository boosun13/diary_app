class User < ApplicationRecord
    has_many :blogs
    has_many :memos
    has_many :comments

    def self.search(search) #self.はUser.を意味する
        if search
            User.where(['name LIKE ?', "%#{search}%"])
        else
            User.all #全て表示させる
        end
    end
end
