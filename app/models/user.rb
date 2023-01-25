class User < ApplicationRecord
    has_secure_password
    has_many :thread_pages
    has_many :comments

    # password length at least 10 characters, cannot be empty, password confirmation required and is case sensitive
    validates :password, length: { minimum: 10 }, presence: true, confirmation: {case_sensitive: true}, unless: -> { password.blank? }
    # username cannot be empty, length at least 3 characters, and must be unique
    validates :username, presence: true, length: {minimum: 3}, uniqueness: {case_sensitive: false}
end
