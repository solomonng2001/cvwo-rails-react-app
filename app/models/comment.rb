class Comment < ApplicationRecord
  belongs_to :thread_page
  belongs_to :user
end
