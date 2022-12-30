class CreateThreadPages < ActiveRecord::Migration[7.0]
  def change
    create_table :thread_pages do |t|
      t.string :title
      t.string :body
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
