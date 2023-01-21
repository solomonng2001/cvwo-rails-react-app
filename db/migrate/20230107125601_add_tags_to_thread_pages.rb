class AddTagsToThreadPages < ActiveRecord::Migration[7.0]
  def change
    add_column :thread_pages, :tags, :string
  end
end
