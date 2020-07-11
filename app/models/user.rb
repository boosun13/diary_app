class User < ApplicationRecord
    has_many :blogs
    has_many :memos
    has_many :comments
end
