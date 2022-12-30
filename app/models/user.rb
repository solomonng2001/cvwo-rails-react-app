class User < ApplicationRecord
    has_many :thread_pages
    has_many :comments
end
