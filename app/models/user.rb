class User < ApplicationRecord
    has_many :blogs
    has_many :memos

end
