class RemoveTagFromThreadPages < ActiveRecord::Migration[7.0]
  def change
    remove_column :thread_pages, :tag, :string
  end
end
