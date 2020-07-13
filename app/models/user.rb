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
    validates :name, presence: true, length: { maximum: 10 }
    validates :password, presence: true
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true , format: { with: VALID_EMAIL_REGEX }
end
