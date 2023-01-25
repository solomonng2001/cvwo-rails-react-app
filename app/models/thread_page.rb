class ThreadPage < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy # delete associated comments when thread is deleted
end
