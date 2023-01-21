class AddTagToThreadPages < ActiveRecord::Migration[7.0]
  def change
    add_column :thread_pages, :tag, :string
  end
end
