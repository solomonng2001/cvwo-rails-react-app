class User < ApplicationRecord
    has_secure_password
    has_many :thread_pages
    has_many :comments

    validates :password, length: { minimum: 10 }, presence: true, confirmation: {case_sensitive: true}, unless: -> { password.blank? }
    validates :username, presence: true, length: {minimum: 3}, uniqueness: {case_sensitive: false}
end
